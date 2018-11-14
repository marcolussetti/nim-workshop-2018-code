import asynchttpserver, asyncdispatch, httpclient, json

var server = newAsyncHttpServer()

proc fetchExchangeRates(): float =
    var client = newHttpClient()
    const apiUrl = "https://api.exchangeratesapi.io/latest"
    let apiResultsRaw = client.getContent(apiUrl)

    let jsonNode = parseJson(apiResultsRaw)
    # doAssert jsonNode.kind == JObject
    # doAssert jsonNode["rates"].kind == JArray
    # doAssert jsonNode["rates"]["DKK"].kind ==
    return(jsonNode["rates"]["USD"].getFloat())


proc requestHandler (request: Request) {.async.} =
    await request.respond(Http200, $(fetchExchangeRates()))

waitFor server.serve(Port(8080), requestHandler)
