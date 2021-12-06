import strutils, sequtils, strformat

var
    file = readFile("input")
    fishes: seq[int8] = @[]
    fileData = file.split(",").mapIt(parseInt(it))
    days = 80


proc newDay(fishes: seq[int8]): seq[int8] =
    var
        newfishes = fishes
    
    let limit = len(fishes)
    
    for i in 0..limit-1:
        if fishes[i] == 0:
            newfishes[i] = 6
            newfishes.add(8)
        else:
            newfishes[i] = fishes[i] - 1
    return newfishes

for fish in fileData:
    fishes.add int8(fish)

for i in 1..days:
    fishes = fishes.newDay
    # echo fmt"day {i} {fishes}"

echo len(fishes)