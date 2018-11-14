import os, random, sequtils, threadpool
{.experimental: "parallel".}

proc inside(): bool =
    let x = rand(1.0)
    let y = rand(1.0)

    return x*x + y*y <= 1


proc estimatePi(attempts: int): tuple[attempts: int, pi: float] =
    var hits = 0
    for i in 0..<attempts:
        if inside(): inc hits
    var pi = hits.float / attempts.float * 4.0
    return (attempts, pi)


proc estimateVariousPi(piValues: seq[int]): seq[tuple[attempts: int, pi: float]] =
    var piResult = piValues.map(proc(value: int): tuple[attempts: int, pi: float] = (value, 0.0) )
    parallel:
        for i in 0..piResult.high:
            piResult[i] = spawn estimatePi(piResult[i].attempts)

    return piResult


randomize()
let pi = estimateVariousPi(@[1_000, 100_000, 1_000_000, 10_000_000, 100_000_000, 1_000_000_000, 2_000_000_000])
echo(pi)
