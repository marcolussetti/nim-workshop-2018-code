import os, strformat, threadpool
{.experimental: "parallel".}

proc printNumber(i: int) =
    sleep(250)
    echo(&"The number is {i}")

proc printNumbers(max: int) =
    for i in 0..<max:
        printNumber(i)

proc printNumbersParallel(max: int) =
    parallel:
        for i in 0..<max:
            spawn printNumber(i)
    sync()


printNumbers(100)
# printNumbersParallel(100)