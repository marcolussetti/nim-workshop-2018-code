import algorithm, math, sugar, strutils

stdout.write("Enter N: ")
let n = parseInt(stdin.readLine())
#let n = 100000000

# var booleanList = array[2..n, bool]
var booleanList = newSeq[bool](n)
booleanList.fill(true)

let nSquare = sqrt(n.float).int

for i in 2..nSquare:
    if booleanList[i]:
        var j = 0
        while i^2 + (j * i) < n:
            booleanList[i^2 + (j * i)] = false
            #j += 1
            inc j

# for i, value in booleanList:
#     if i < 2:
#         continue
#     if value:
#         echo(i)

let output = lc[index | (index <- booleanList.low .. booleanList.high, index >= 2 and booleanList[index] == true), int]
echo(output)
