import os, random, sequtils, threadpool
{.experimental: "parallel".}

proc inside(): bool =
    let x = rand(1.0)
    let y = rand(1.0)

    return x*x + y*y <= 1


proc estimatePi(attempts: int) =
    var hits = 0
    for i in 0 ..< attempts:
        if inside(): inc hits
    var pi = hits.float / attempts.float * 4.0
    echo (attempts, pi)


proc estimateVariousPi(piValues: seq[int]) =
    for i in 0..piValues.high:
        spawn estimatePi(piValues[i])
    sync()



randomize()
let variousPi : seq[int] = @[2_000_000_000, 2_000_000_000]
estimateVariousPi(variousPi)
