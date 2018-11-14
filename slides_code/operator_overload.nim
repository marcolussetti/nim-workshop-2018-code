let a = @[1, 2, 3, 4, 5]
let b = @[2, 2, 2, 2, 2]

let c = a + b # ERROR!

proc `+`(a: seq[int], b: seq[int]): seq[int] =
    var c = newSeq[int]()
    for i in 0..max(a.len(), b.len()):
        if i < a.len() and i < b.len():
            c[i] = a[i] + b[i]
        elif i < a.len():
            c[i] = a[i]
        else:
            c[i] = b[i]

    return c

let c = a + b
echo(c)
