import strutils, sequtils, strformat

const
    mapSize = 1000

type Map* = array[mapSize, array[mapSize, int8]]

var
    map: Map

    file = readFile("input")
    lines = file.splitLines()

proc addToMap(map: Map, x1, y1, x2, y2: int): Map = 
    if (x1 == x2 and y1 != y2) or (y1 == y2 and x1 != x2):
        var 
            nmap = map
            smallerx = min(x1, x2)
            biggerx = max(x1, x2)
            smallery = min(y1, y2)
            biggery = max(y1, y2)
        
        for x in smallerx..biggerx:
            for y in smallery..biggery:
                inc nmap[y][x]
        result = nmap
    else:
        result = map

proc printMap(map: Map): void =
    for line in map:
        for pos in line:
            stdout.write fmt"{pos} "
        stdout.write("\n")

proc getResult(map: Map): void =
    var result = 0
    for row in map:
        for pos in row:
            if pos > 1:
                inc result
    echo fmt"RESULT = {result}"

for line in lines:
    echo "newline"
    if line == "": continue
    let
        coordSeq = line.split("->")
        first = coordSeq[0].split(",")
        second = coordSeq[1].split(",")
        x1 = parseInt(first[0].strip())
        y1 = parseInt(first[1].strip())
        x2 = parseInt(second[0].strip())
        y2 = parseInt(second[1].strip())

    # echo fmt"x1={x1} y1={y1} x2={x2} y2={y2}"
    # echo typeof(x1)
    # echo typeof(x2)
    # echo typeof(y1)
    # echo typeof(y2)
    # map = addToMap
    map = map.addToMap(x1, y1, x2, y2)
    # printMap map
    # echo "===="

getResult map



