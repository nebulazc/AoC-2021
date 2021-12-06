import strutils, sequtils, strformat, tables

const
    days = 80
    newfish = 8
    rest = 6

var
    file = readFile("testinput")
    fileData = file.split(",").mapIt(parseInt(it))
    # alreadyCalculated = initTable[int, int64]()
    alreadyCalculated: array[6, int64] = [int64(-1), int64(-1), int64(-1), int64(-1), int64(-1), int64(-1)]
    superresult: int64 = 0

# 1 = 6

# proc generateLifespan(fishArray: array[days, int]): array[days, int] = 
#     # 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 
#     # 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0
#     # 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
#     result = fishArray
#     var
#         i = 0
#         firstTime = true
#     while i < days:
#         var
#             newArr: array[days, int]
#         if fishArray[i] > 0:
            

# proc generateLife(start: int, exists: bool): int =
#     # echo fmt"{start} {exists}"
#     var
#         sum = 0
#         firstTime = true
#         i = start
#     while i < days:
#         if firstTime:
#             inc(i, newfish)
#             firstTime = false
#         else:
#             inc(i, rest)
#         inc(sum, 1)
#         inc(sum, generateLife(i, true))

#     return sum

# proc generateLife(start: int, firstTime: bool, parent: int): int =
#     var
#         sum = 0
#         firstTime = firstTime
#         i = start
#     while i < days:
#         if firstTime:
#             inc(i, newfish)
#             firstTime = false
#         else:
#             inc(i, rest)
#         if i <= days:
#             inc(sum, 1)
#         inc(sum, generateLife(i, true, start))
    
#     echo fmt"{parent} -> {start} {firstTime} ===== {sum}"
#     inc(superresult, sum)
#     return sum

proc generateLife(cooldown: int, day: int): int64 =
    var i = day
    var cancer: int64 = 0
    var tempcooldown = cooldown
    while i <= days:
        if tempcooldown == 0:
            # echo i
            # inc result
            inc superresult
            # inc(result, generateLife(9,i))
            cancer += generateLife(9, i)
            # generateLife(9, i)
            tempcooldown = 7
        inc i
        inc(tempcooldown, -1)
    return cancer




for fish in fileData:
    echo fmt"calculating {fish}"
    echo typeof(fish)
    inc superresult
    if alreadyCalculated[fish] == int64(-1):
        let calculated = generateLife(fish, 1)
        echo fmt"WTF {calculated}"
        alreadyCalculated[fish] = calculated
    else:
        echo "already calculated"
        # alreadyCalculated[fish] = 69
    # inc(superresult, alreadyCalculated[fish])
    superresult += alreadyCalculated[fish]
    echo superresult

echo "==== ANSWER ====="
echo superresult

echo "calculated = "

echo alreadyCalculated[0]
echo alreadyCalculated[1]
echo alreadyCalculated[2]
echo alreadyCalculated[3]
echo alreadyCalculated[4]
echo alreadyCalculated[5]

