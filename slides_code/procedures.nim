proc addTwo(a, b: int) =
    echo(a + b)

addTwo(1, 2)

# Overloading & return values
proc addTwo(a, b: float): float =
    return a + b

let theSum = addTwo(3.0, 2.0)
echo(theSum)

# Modifying input
proc concatenateToString(a, b: string) =
    a = a & b # ERROR!

proc concatenateToString(a: var string, b: string) =
    a = a & b

var f = "Test"
concatenateToString(f, "ing")
echo(f)

# Everything is passed by value!!!
