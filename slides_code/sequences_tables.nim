import strutils
var sequence: seq[int]
sequence = @[1, 2, 3, 4, 5]
var anotherSequence = newSeq[int](1) # empty
sequence.add(6)
echo(sequence.join(","))

# Slices
echo(sequence[0..2].join(","))

# Tuples
let aTuple = (hello: "world")
echo(aTuple.hello)

var anotherTuple: tuple[hello: string]
anotherTuple = (hello: "World")

# Tables ("Hashmaps"/"Dictionaries")
import tables
var a = {"Humphrey": "Bogart", "James": "Cagney"}.toTable
var b = a
b["James"] = "Stewart"
echo(b)
echo(a) # Copy by value!

# Create a TableRef instead
var c = {"Gish": "Lillian", "Hepburn": "Katharine"}.newTable
var d = c
d["Hepburn"] = "Audrey"
echo(c)
