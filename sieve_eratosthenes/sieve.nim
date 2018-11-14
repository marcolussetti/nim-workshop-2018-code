import algorithm, math, strutils

stdin.write("Enter N> ")
var n = parseInt(readLine(stdin))
var booleanList = newSeq[bool](n)
booleanList.fill(true)
# fill(booleanList, true)

var nSquare = sqrt(n.float).int

for i in 2..nSquare:
    if booleanList[i]:
        var j = 0
        while i^2 + (j * i) < n:
            booleanList[i^2 + (j * i)] = false
            inc j

for index, value in booleanList:
    if value:
        echo(index)
