import strutils, sequtils, strformat

var
    file = readFile("input")
    lines = file.splitLines()
    result: int = 0

echo lines

for line in lines:
    if line == "": continue
    let
        arr = line.split(" | ")
        inputarr = arr[0].split(" ")
        outputarr = arr[1].split(" ")

    for output in outputarr:
    # 2 3 4 7
        if len(output) == 2 or len(output) == 3 or len(output) == 4 or len(output) == 7:
            inc result

echo result
