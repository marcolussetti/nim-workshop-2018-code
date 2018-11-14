import os, random

proc inside(): bool =
    let x = rand(1.0)
    let y = rand(1.0)

    return x*x + y*y <= 1

proc estimatePi(attempts: int): float =
    var hits = 0
    for i in 0..<attempts:
        if inside():
            inc hits

    var pi = hits.float / attempts.float * 4.0
    return pi


randomize()
let pi = estimatePi(2_000_000_000)
echo(pi)
