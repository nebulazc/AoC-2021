import strformat, strutils, sequtils, tables, algorithm, math

const
    turns = 100

type
    Octopus* = object
        level: int
        flashed: bool

let
    file = readFile("input")
    lines = file.splitLines()

var
    octopuses = initTable[(int, int), Octopus]()
    toFlash: seq[(int, int)]
    result = 0

proc resetOctopuses() = 
    for key in octopuses.keys:
        if octopuses[key].flashed == true:
            octopuses[key].flashed = false
            octopuses[key].level = 0

proc increaseAll() = 
    for key in octopuses.keys:
        inc octopuses[key].level
        if octopuses[key].level > 9:
            toFlash.add key


proc tryFlash(key: (int, int)) = 
    if octopuses[key].level > 9 and octopuses[key].flashed == false:
        inc result
        octopuses[key].flashed = true
        for i in key[0]-1..key[0]+1:
            for j in key[1]-1..key[1]+1:
                if (i, j) != key:
                    try:
                        inc octopuses[(i, j)].level
                        tryFlash((i, j))
                    except KeyError:
                        continue

for i in 0..len(lines)-1:
    if lines[i] == "": continue
    for j in 0..len(lines[0])-1:
        octopuses[(j,i)] = Octopus(level : parseInt(fmt"{lines[i][j]}"),
                                   flashed : false)

for i in 1..turns:
    toFlash = @[]
    increaseAll()
    for key in toFlash:
        tryFlash(key)
    resetOctopuses()
    # echo octopuses

echo result