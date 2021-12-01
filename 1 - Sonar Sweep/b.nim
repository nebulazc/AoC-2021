import strutils, sequtils

var 
    file = readFile("input").splitLines()
    values = file.mapIt(parseInt(it))
    prev = toInt(-Inf)
    sumcount = 0
for i in 0..values.len-4:
    let sum = values[i] + values[i+1] + values[i+2]
    if sum > prev:
        inc sumcount
    prev = sum
echo sumcount

