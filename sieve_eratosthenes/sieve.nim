import algorithm
import math

var n = 1000
var booleanList = newSeq[bool](n)
booleanList.fill(true)
# fill(booleanList, true)

var nSquare = sqrt(n.float).int

# iterator rangeJ(i: int, max: int): int =
#     var j = 0
#     while i^2 + (j * i) < max:
#         yield i^2 + (j * i)
#         inc j
#
# for i in 2..nSquare:
#     if booleanList[i]:
#         for j in rangeJ(i, n):
#             booleanList[j] = false

for i in 2..nSquare:
    if booleanList[i]:
        var j = 0
        while i^2 + (j * i) < n:
            booleanList[i^2 + (j * i)] = false
            inc j

# Output
for index, value in booleanList:
    if value:
        echo(index)
