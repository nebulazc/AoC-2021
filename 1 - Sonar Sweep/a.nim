import sequtils, strutils

var 
    count = 0
    file = readFile("input").splitLines()
    values = file.mapIt(parseInt(it))

for i in 1..values.len-1:
    if values[i-1] < values[i]:
        inc count
        
echo count