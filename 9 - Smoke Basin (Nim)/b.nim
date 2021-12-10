import strformat, strutils, sequtils, algorithm, math, tables

type
    Space* = object
        value: int
        checked: bool

let
    file = readFile("input")
    lines = file.splitLines()
    mapHeight = len(lines)
    mapWidth = len(lines[0])

var
    map: seq[seq[Space]]
    lowestpoints: seq[(int, int)]
    basinData = initTable[(int, int), int]()
    result = 0

for i in 0..mapHeight-1:
    map.add @[]
    for j in 0..mapWidth-1:
        map[i].add Space(value : parseInt(fmt"{lines[i][j]}"),
                         checked : false)

for i in 0..mapHeight-1:
    for j in 0..mapWidth-1:
        var elem = map[i][j].value
        if i > 0:
            if map[i-1][j].value <= elem:
                continue
        if i < mapHeight - 1:
            if map[i+1][j].value <= elem:
                continue
        if j > 0:
            if map[i][j-1].value <= elem:
                continue
        if j < mapWidth - 1:
            if map[i][j+1].value <= elem:
                continue
        lowestpoints.add (i,j)

proc incBasinData(x, y : int) = 
    try:
        inc basinData[(x,y)]
    except KeyError:
        basinData[(x,y)] = 1


proc findBasin(x, y, originx, originy : int) = 
    if x > 0:
        if map[y][x-1].value < 9 and not map[y][x-1].checked:
            incBasinData(originx, originy)
            map[y][x-1].checked = true
            findBasin(x-1, y, originx, originy)
    if x < mapWidth - 1:
        if map[y][x+1].value < 9 and not map[y][x+1].checked:
            incBasinData(originx, originy)
            map[y][x+1].checked = true
            findBasin(x+1, y, originx, originy)     
    if y > 0:
        if map[y-1][x].value < 9 and not map[y-1][x].checked:
            incBasinData(originx, originy)
            map[y-1][x].checked = true
            findBasin(x, y-1, originx, originy)
    if y < mapHeight - 1:
        if map[y+1][x].value < 9 and not map[y+1][x].checked:
            incBasinData(originx, originy)
            map[y+1][x].checked = true
            findBasin(x, y+1, originx, originy)

for point in lowestpoints:
    findBasin(point[1], point[0], point[1], point[0])


var valuesseq: seq[int]

for val in basinData.values:
    valuesseq.add val

valuesseq.sort(Descending)

echo valuesseq[0] * valuesseq[1] * valuesseq[2]