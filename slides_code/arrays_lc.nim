var x: array[0..4, int]
x = [1, 2, 3, 4, 5]

let y: array[0..4, int] = [5, 4, 3, 2, 1]

for i in x.low .. x.high:
    if (i mod 2 == 0): echo(x[i] * 2)

# OR, For-each
for i in x:
    if (i mod 2 == 0): echo(x[i] * 2)


# OR, list comprehension
import sugar
let sums = lc[i * 2 | (i <- x, i mod 2 == 0), int]

import strutils
echo(sums.join(", "))

# OR, filter + map
import sequtils
let otherSums = x.filter(proc(num: int): bool = num mod 2 == 0).map(proc(num: int): int = num * 2)

otherSums.join(", ").echo()
