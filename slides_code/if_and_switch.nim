# If statement
let inputString = stdin.readLine()

if inputString == "":
    echo("No input provided")
elif inputString == "test":
    echo("Test successful")
else:
    echo("Incorrect input")

# Case/Switch statement
let inputString = stdin.readLine()

case inputString
of "":
    echo("No input provided")
of "test":
    echo("Test successful")
else:
    echo("Incorrect input")
