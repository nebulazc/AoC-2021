import strutils, sequtils, strformat, tables, algorithm

var
    file = readFile("testinput")
    lines = file.splitLines()
    result: int = 0
    potentialSegments: seq[Table[char, seq[int]]]
    confirmedSegments = initTable[string, string]()

const
    segments = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
    confirmedLens = {2: 1, 3: 7, 4: 4, 7: 8}.toTable
    # coverTable: Table[char, seq[int]] = { 'a': @[7,8], 'b': @[4,8], 'c': @[1,4,7,8], 'd': @[4,8], 'e': @[8], 'f': @[1,4,7,8], 'g': @[8] }.toTable
    coverTable: Table[char, seq[int]] = { 'a': @[0,2,3,5,6,7,8,9], 'b': @[4,5,6,8,9], 'c': @[0,1,2,3,4,7,8,9], 'd': @[2,3,4,5,6,8,9], 'e': @[0,2,8], 'f': @[0,1,3,4,5,6,7,8,9], 'g': @[0,2,3,5,6,8,9] }.toTable

for lineIndex in 0..len(lines) - 1:
    if lines[lineIndex] == "": continue
    var t = initTable[char, seq[int]]()
    for seg in segments:
        t[seg] = @[]
    potentialSegments.add t

    if lines[lineIndex] == "": continue
    let
        fixedString = lines[lineIndex].replace(" | ", " ")
        fixedArr = fixedString.split(" ")
        arr = lines[lineIndex].split(" | ")
        inputarr = arr[0].split(" ")
        outputarr = arr[1].split(" ")

    echo "fixed below"
    echo fixedString

    for x in fixedArr:
        if len(x) == 2 or len(x) == 3 or len(x) == 4 or len(x) == 7:
            for i in 0..len(x) - 1:
                if confirmedLens[len(x)] notin potentialSegments[lineIndex][x[i]]:
                    potentialSegments[lineIndex][x[i]].add confirmedLens[len(x)]


for i in 0..len(potentialSegments) - 1:
    for key in potentialSegments[i].keys:
        sort(potentialSegments[i][key], system.cmp)
    

for x in potentialSegments:
    echo x
    echo "========"

proc solveShit(table: Table[char, seq[int]]): Table[char, char] =
    result = {'a': 'z', 'b': 'z', 'c': 'z', 'd': 'z', 'e': 'z', 'f': 'z', 'g': 'z' }.toTable

    for key in table.keys:
        for ckey in coverTable.keys:
            if table[key] == coverTable[ckey]:
                result[ckey] = key
                break

echo "SOLVING"
for x in potentialSegments:
    echo x
    echo "solved"
    echo solveShit(x)

    
