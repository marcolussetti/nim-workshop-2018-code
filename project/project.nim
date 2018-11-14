import asynchttpserver, asyncdispatch, parsecsv, httpclient, json, times, strutils, sequtils, sugar, strformat
import asciigraph

type
    CrimeReport = tuple[
        reportNumber: int, occurredDate: DateTime,
        reportedDate: DateTime, crimeCategory: string,
        neighbourhood: string
    ]
    CrimeDataset = seq[CrimeReport]

var dataset {.threadvar.} : CrimeDataset

var server = newAsyncHttpServer()

# proc fetchExchangeRates(): float =
#     var client = newHttpClient()
#     const apiUrl = "https://api.exchangeratesapi.io/latest"
#     let apiResultsRaw = client.getContent(apiUrl)

#     let jsonNode = parseJson(apiResultsRaw)
#     return(jsonNode["rates"]["USD"].getFloat())


proc fetchOrLoadCrimeData(): seq[CrimeReport] =
    # See https://data.seattle.gov/Public-Safety/Crime-Data/4fs7-3vj5
    var parser: CsvParser
    parser.open("Crime_Data.csv")
    #const url = "https://data.seattle.gov/api/views/4fs7-3vj5/rows.csv?accessType=DOWNLOAD"
    #var client = newHttpClient()
    parser.readHeaderRow()
    var data: seq[CrimeReport] = newSeq[CrimeReport]()
    discard parser.readRow()
    while parser.readRow():
        var rawRecord = @[
            parser.rowEntry(parser.headers[0]),
            parser.rowEntry(parser.headers[1]), parser.rowEntry(parser.headers[2]),
            parser.rowEntry(parser.headers[3]), parser.rowEntry(parser.headers[4]),
            parser.rowEntry(parser.headers[5]),
            parser.rowEntry(parser.headers[0])
        ]
        if rawRecord[2].len() == 2 or rawRecord[4].len() == 2:
            continue
        if rawRecord[2].len() < 3:
            rawRecord[2] = rawRecord[2] & "00"
        if rawRecord[4].len() < 3:
            rawRecord[4] = rawRecord[4] & "00"
        if rawRecord[2].len() == 3:
            rawRecord[2] = "0" & rawRecord[2]
        if rawRecord[4].len() == 3:
            rawRecord[4] = "0" & rawRecord[4]
        try:
            let record = (
                parseInt(rawRecord[0]),
                parse(rawRecord[1] & " " & rawRecord[2], "MM/dd/yyyy HHmm"),
                parse(rawRecord[3] & " " & rawRecord[4], "MM/dd/yyyy HHmm"),
                rawRecord[5],
                rawRecord[6]
            )
            data.add(record)
        except ValueError:
            continue

    return data

proc crimeCountByMonth(year: int, month: Month): int =
    return dataset.filter(
        proc(record: CrimeReport): bool = record.occurredDate.year == year and record.occurredDate.month == month
    ).len()

proc yearInCrime(year: int): seq[float] =
    #let yearInCrimeData = lc[(month, crimeCountByMonth(year, Month(month)) / 100) | (month <- 1..12), (int, float)]
    let yearInCrimeData = lc[crimeCountByMonth(year, Month(month)) / 100 | (month <- 1..12), float]
    return yearInCrimeData

proc asciiPlotYearInCrime(year: int): string =
    let yearInCrimeData = yearInCrime(year)
    return plot(yearInCrimeData)



proc requestHandler (request: Request) {.async.} =
    # await request.respond(Http200, $(fetchExchangeRates()))
    echo(fmt"Request received for {request.url.path}")
    if request.url.path == "/":
        await request.respond(Http404, "Please specify a year!")
    else:
        try:
            let year = parseInt(request.url.path.strip(chars={'/'}))
            var plot = asciiPlotYearInCrime(year)
            var response = &"<html><head><meta charset='UTF-8'></head><body><h1>{year}</h1><pre>{plot}</pre></body></html>"
            await request.respond(Http200, response)
        except ValueError:
            await request.respond(Http404, "Not Found.")



echo("Loading Data")
dataset = fetchOrLoadCrimeData()
echo("Loaded Data. Try browing to http://localhost:8080")

# echo(dataset.crimeCountByMonth(2018, Month(2)))
# echo(asciiPlotYearInCrime(2017))



waitFor server.serve(Port(8080), requestHandler)
