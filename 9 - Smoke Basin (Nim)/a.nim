import strformat, strutils, sequtils, algorithm, math

let
    file = readFile("input")
    lines = file.splitLines()
    mapHeight = len(lines)
    mapWidth = len(lines[0])

var
    map: seq[seq[int]]
    result = 0

for i in 0..mapHeight-1:
    map.add @[]
    for j in 0..mapWidth-1:
        map[i].add parseInt(fmt"{lines[i][j]}")

for i in 0..mapHeight-1:
    for j in 0..mapWidth-1:
        var elem = map[i][j]
        if i > 0:
            if map[i-1][j] <= elem:
                continue
        if i < mapHeight - 1:
            if map[i+1][j] <= elem:
                continue
        if j > 0:
            if map[i][j-1] <= elem:
                continue
        if j < mapWidth - 1:
            if map[i][j+1] <= elem:
                continue
        inc(result, elem + 1)

echo result