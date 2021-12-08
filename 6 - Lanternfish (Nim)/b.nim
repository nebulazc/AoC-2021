import strutils, sequtils, strformat, tables

const
    days = 256

var
    file = readFile("input")
    fileData = file.split(",").mapIt(parseInt(it))
    # alreadyCalculated = initTable[int, int64]()
    alreadyCalculated: array[6, int64] = [int64(-1), int64(-1), int64(-1), int64(-1), int64(-1), int64(-1)]
    superresult: int64 = 0


proc generateLife(cooldown: int, day: int): int64 =
    var i = day
    var tempcooldown = cooldown
    while i <= days:
        if tempcooldown == 0:
            inc result
            result += generateLife(9, i)
            tempcooldown = 7
        inc i
        inc(tempcooldown, -1)




for fish in fileData:
    inc superresult
    if alreadyCalculated[fish] == int64(-1):
        let calculated = generateLife(fish, 1)
        alreadyCalculated[fish] = calculated
    else:
    superresult += alreadyCalculated[fish]
    echo superresult

echo "==== ANSWER ====="
echo superresult

echo "calculated = "

echo alreadyCalculated[1]
echo alreadyCalculated[2]
echo alreadyCalculated[3]
echo alreadyCalculated[4]
echo alreadyCalculated[5]

