import strutils, sequtils, strformat, math, algorithm, tables

let
    file = readFile("input")
    lines = file.splitLines()

var
    connectionTable = initTable[string, seq[string]]()
    result = 0

proc generatePaths(currpos : string, visited : seq[string]) = 
    var newvisited = visited
    if currpos[0].isLowerAscii:
        newvisited.add currpos
    if currpos == "end":
        inc result
        return
    for connection in connectionTable[currpos]:
        if connection != "start" and connection notin visited:
            generatePaths(connection, newvisited)

for line in lines:
    if line == "": continue
    var
        a = line.split("-")
        startpos = a[0]
        endpos = a[1]
    

    try:
        connectionTable[startpos].add endpos
    except:
        connectionTable[startpos] = @[endpos]

    try:
        connectionTable[endpos].add startpos
    except:
        connectionTable[endpos] = @[startpos]

for branch in connectionTable["start"]:
    generatePaths(branch, @[])

echo result