# Declaration
var x: int

# Assignation
var y = 5 # infers int
y = 6

# Immutable variable ("single assignment")
let z = 5
z = 7 # ERROR!

# Compile-time constant
const k = 3 + 2
const l = stdin.readLine() # ERROR!
let l = stdin.readLine()
