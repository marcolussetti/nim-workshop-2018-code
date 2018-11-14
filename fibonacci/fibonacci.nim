import strutils

proc fib(n: uint): uint =
    if n <= 1:
        return 1
    return fib(n - 1) + fib(n - 2)

echo(fib(parseUInt(readLine(stdin))))
