import strutils, strformat, algorithm, math, lists, tables

var
    result = 0

let
    file = readFile("input")
    lines = file.splitLines()

const
    opening = ['(', '[', '<', '{']
    closing = [')', ']', '>', '}']
    charTable = {')': '(', ']': '[', '>': '<', '}': '{'}.toTable()
    scoreTable = {')': 3, ']': 57, '}': 1197, '>': 25137}.toTable()

for line in lines:
    var
        bracketsList = initSinglyLinkedList[char]()
        valid = true
        illegalChar: char
    if line == "": continue

    for x in line:
        if x in opening:
            bracketsList.prepend(x)
        elif x in closing:
            if bracketsList.head.value == charTable[x]:
                echo bracketsList
                bracketsList.remove(bracketsList.head)
                echo bracketsList
                echo "=========="
            else:
                valid = false
                illegalChar = x
                break
    
    if not valid:
        inc(result, scoreTable[illegalChar])

echo result
