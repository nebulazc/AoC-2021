import strutils, sequtils, strformat, algorithm, math

let
    file = readFile("input")
    crabs = file.split(",").mapIt(parseInt(it))

var
    min, max: int

for crab in crabs:
    if crab < min: min = crab
    if crab > max: max = crab


var
    result = 999999999999
    tempsol: int
    c: int
    pos: int

for i in min..max:
    tempsol = 0
    for crab in crabs:
        c = 1
        pos = crab
        while pos != i:
            inc(tempsol, abs(c))
            if pos < i:
                inc pos
            else:
                inc(pos, -1)
            inc c 
    if tempsol < result:
        result = tempsol

echo result