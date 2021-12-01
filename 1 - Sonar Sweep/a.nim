import strutils

var prev: int = -1
var count: int = 0

while true:
    let input = readLine(stdin)
    if input != "":
        var parsedInput = parseInt(input)
        if prev != -1:
            if parsedInput > prev:
                inc count
        prev = parsedInput
    else: break
echo count