import sequtils, strutils, strformat, tables, hashes, math, algorithm

const
    filename = "input"

let
    file = readFile(filename)
    coords = file.split(":")[1].strip().split()
    x1 = parseInt(coords[0].split("..")[0][2..^1])
    x2 = parseInt(coords[0].split("..")[1][0..^2])
    y1 = parseInt(coords[1].split("..")[0][2..^1])
    y2 = parseInt(coords[1].split("..")[1])

    minx = min(x1, x2)
    maxx = max(x1, x2)
    miny = min(y1, y2)
    maxy = max(y1, y2)

    target = ((minx..maxx).toSeq, (miny..maxy).toSeq)

# echo x1
# echo x2
# echo y1
# echo y2

# echo target

var
    dir: int

if minx > 0:
    dir = 1
else:
    dir = -1

proc simulate(velx, vely : var int) : int = 
    # echo fmt"testing {velx} {vely}"
    var
        x, y, maxy : int = 0

    while y > miny:
        x.inc velx
        y.inc vely
        if y > maxy: maxy = y
        if velx != 0:
            velx.inc -dir
        vely.inc -1

        if x in target[0] and y in target[1]:
            return maxy
    
    return -1

var
    result = 0

# let ybound = toInt((miny * (miny + 1)) / 2)
let ybound = 1000

for i in 1..maxx+5:
    stdout.write "|"
    for j in -ybound..ybound:
        var t = (i * dir)
        var ty = j
        let res = simulate(t, ty)
        if res != -1:
            result.inc

echo result
# while true:
#     if simulate(x,y):
#         echo "result found"
#         echo y
#         break
#     else:
#         y.inc