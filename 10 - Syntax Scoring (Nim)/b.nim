import strutils, strformat, algorithm, math, lists, tables

var
    results: seq[int]

let
    file = readFile("input")
    lines = file.splitLines()

const
    opening = ['(', '[', '<', '{']
    closing = [')', ']', '>', '}']
    charTable = {')': '(', ']': '[', '>': '<', '}': '{'}.toTable()
    scoreTable = {'(': 1, '[': 2, '{': 3, '<': 4}.toTable()

for line in lines:
    var
        bracketsList = initSinglyLinkedList[char]()
        valid = true
        tres = 0

    if line == "": continue

    for x in line:
        if x in opening:
            bracketsList.prepend(x)
        elif x in closing:
            if bracketsList.head.value == charTable[x]:
                bracketsList.remove(bracketsList.head)
                discard 
            else:
                valid = false
                break
    

    if valid:
        for item in bracketsList.items:
            tres *= 5
            inc(tres, scoreTable[item])

    if tres > 0:
        results.add tres

results.sort()
echo results[int(floor(len(results) / 2))]

