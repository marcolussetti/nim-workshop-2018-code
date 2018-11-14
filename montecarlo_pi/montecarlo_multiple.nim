import os, random, sequtils

proc inside(): bool =
    let x = rand(1.0)
    let y = rand(1.0)

    return x*x + y*y <= 1


proc estimatePi(attempts: uint64): tuple[attempts: uint64, pi: float] =
    var hits = 0
    for i in 0.uint64 ..< attempts:
        if inside(): inc hits
    var pi = hits.float / attempts.float * 4.0
    return (attempts, pi)


proc estimateVariousPi(piValues: seq[uint64]): seq[tuple[attempts: uint64, pi: float]] =
    var piResult = piValues.map(proc(value: uint64): tuple[attempts: uint64, pi: float] = (value, 0.0) )
    for i in 0..piResult.high:
        piResult[i] = estimatePi(piResult[i].attempts)

    return piResult


randomize()
let variousPi : seq[uint64] = @[2_000_000_000.uint64, 2_000_000_000.uint64, 2_000_000_000.uint64, 2_000_000_000.uint64]
let pi = estimateVariousPi(variousPi)
echo(pi)
