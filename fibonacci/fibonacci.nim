import os, strutils

proc fib(n: uint): uint =
    if n <= 1:
        return 1
    return fib(n - 1) + fib(n - 2)

var fibNumber : uint
if paramCount() == 0:
    stdout.write("Enter Nth Fibonacci to compute: ")
    fibNumber = parseUInt(readLine(stdin))
else:
    fibNumber = parseUInt(paramStr(1))

echo(fib(fibNumber))
