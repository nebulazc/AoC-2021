import sequtils, strutils, tables, math, algorithm, strformat

let
    file = readFile("input")
    lines = file.splitLines()

var
    map: seq[(int, int)]
    mapheight = 0
    mapwidth = 0
    instructions = false

proc printMap() : void = 
    for y in 0..mapheight:
        for x in 0..mapwidth:
            if (x,y) in map:
                stdout.write "#"
            else:
                stdout.write "."
        stdout.write("\n")

proc fold(dir : string, val : int) : void = 
    var nmap = map
    if dir == "x":
        mapwidth = val + 2
        for point in map:
            if point[0] > val:
                let
                    diff = point[0] - val
                    nx = val - diff
                if (nx, point[1]) notin nmap:
                    nmap.add (nx, point[1])
    elif dir == "y":
        mapheight = val + 2
        for point in map:
            if point[1] > val:
                let
                    diff = point[1] - val
                    ny = val - diff
                if (point[0], ny) notin nmap:
                    nmap.add (point[0], ny)
    map = nmap

proc cleanMap(dir : string, val : int, ) : void =
    if dir == "x":
        map = map.filterIt(it[0] < val)
    elif dir == "y":
        map = map.filterIt(it[1] < val)

for line in lines:
    echo line
    if line == "":
        instructions = true
        # printMap()
        continue

    if instructions:
        var
            x = line.split(" ")
            a = x[2].split("=")
            foldDir = a[0]
            foldVal = a[1]
        
        fold(foldDir, parseInt(foldVal))
        cleanMap(foldDir, parseInt(foldVal))
        # break  # <- uncomment this for part 1

    else:
        var
            a = line.split(",")
            x = parseInt(a[0])
            y = parseInt(a[1])
        map.add (x, y)
        if x > mapwidth: mapwidth = x
        if y > mapheight: mapheight = y

echo len(map)
printMap()