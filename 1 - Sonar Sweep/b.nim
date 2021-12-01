import strutils, strformat, tables

var
    # final sum seq
    results: seq[int]
    # table to store the 3 measurements
    valueTable = initTable[int, seq[int]]()
    # to what measurement windows we add the value from file
    toAdd = @[0,]
    
    value: int

    # our key for table
    count = 0
    # what measurement window we stop using after getting 3 measurements for it
    toDelete = -1

    finalCount = 0
    file = readFile("input").splitLines()

for line in file:
    try:
        value = parseInt(line)        
    except ValueError:
        echo "Reached end of file"

    for key in toAdd:
        try:
            valueTable[key].add(value)
        except KeyError:
            valueTable[key] = @[value]

        if valueTable[key].len == 3:
            results.add(valueTable[key][0] + valueTable[key][1] + valueTable[key][2])
            toDelete = key
            valueTable.del(key)
    
    # you cant change seq while youre in a `for` loop for it, thats why we delete value from toAdd outside the loop
    if toDelete != -1:
        toAdd.delete(toAdd.find(toDelete))
        toDelete = -1
    
    inc count
    toAdd.add(count)

# get results
for i in 1..results.len-2:
    if results[i] > results[i-1]:
        inc finalCount

echo finalCount
