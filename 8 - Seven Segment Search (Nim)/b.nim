import strutils, sequtils, strformat, tables, algorithm, math

#   0:      1:      2:      3:      4:
#  aaaa    ....    aaaa    aaaa    ....
# b    c  .    c  .    c  .    c  b    c
# b    c  .    c  .    c  .    c  b    c
#  ....    ....    dddd    dddd    dddd
# e    f  .    f  e    .  .    f  .    f
# e    f  .    f  e    .  .    f  .    f
#  gggg    ....    gggg    gggg    ....
# 
#   6       2        5      5       4
# 
# 
# 
#   5:      6:      7:      8:      9:
#  aaaa    aaaa    aaaa    aaaa    aaaa
# b    .  b    .  .    c  b    c  b    c
# b    .  b    .  .    c  b    c  b    c
#  dddd    dddd    ....    dddd    dddd
# .    f  e    f  .    f  e    f  .    f
# .    f  e    f  .    f  e    f  .    f
#  gggg    gggg    ....    gggg    gggg
# 
#   5       6       3        7      6
# 
#  a d b g e c f

const keycodes = {0: "abcefg", 1: "cf", 2: "acdeg", 3: "acdfg", 4: "bcdf", 5: "abdfg", 6: "abdefg", 7: "acf", 8: "abcdefg", 9: "abcdfg"}.toTable

var
    result: int64 = 0

let
    file = readFile("input")
    lines = file.splitLines()

proc solveLine(valArr: seq[string]): Table[char, char] =
    #     aaaa
    #    b    c
    #    b    c
    #     dddd
    #    e    f
    #    e    f
    #     gggg
    
    var solved = ""

    # STEP 1: get a
    var
        threeelem: string # seven
        twoelem: string # one
    
    for elem in valArr:
        if len(elem) == 2:
            twoelem = elem
        elif len(elem) == 3:
            threeelem = elem

    # echo fmt"two elem {twoelem} three elem {threeelem}"
    for x in threeelem:
        if x notin twoelem:
            result['a'] = x
            solved.add x
            break
    
    echo fmt"a = {result['a']}"

    # STEP 2: get d
    # from `3` we get d and g and then compare to `4`

    var
        fourelem: string
        fivelem: seq[string]

    for elem in valArr:
        if len(elem) == 4:
            fourelem = elem
        elif len(elem) == 5:
            fivelem.add elem


    for elem in fivelem:
        # for elem in 2 3 5
        var passed = true
        for tempx in twoelem:
            if tempx notin elem:
                passed = false
        if passed:
            # we know its 3
            for x in fourelem:
                if x notin twoelem and x in elem:
                    result['d'] = x
                    solved.add x
                    break
    
    echo fmt"d = {result['d']}"

    # STEP 3: get b

    for x in fourelem:
        if x notin twoelem and x != result['d']:
            result['b'] = x
            solved.add x
    
    echo fmt"b = {result['b']}"

    # STEP 4: get g
    # from `9`

    var
        sixelem: seq[string]
        nineString: string

    for elem in valArr:
        if len(elem) == 6:
            sixelem.add elem
    
    for elem in sixelem:
        # first we rule out 0
        if result['d'] in elem:
            var passed = true
            for tempx in twoelem:
                if tempx notin elem:
                    passed = false
            
            if passed:
                # its a 9
                nineString = elem
                for x in elem:
                    if x notin twoelem and x notin solved:
                        result['g'] = x
                        solved.add x
    
    echo fmt"g = {result['g']}"

    # STEP 5: get e
    for elem in sixelem:
        if result['d'] in elem:
            var passed = true
            for tempx in twoelem:
                if tempx notin elem:
                    passed = false
            
            if not passed:
                # its a 6
                for x in elem:
                    if x notin nineString:
                        result['e'] = x
                        solved.add x

    echo fmt"e = {result['e']}"

    # STEP 6: get c and f
    # from `5` and `3`
    var
        fiveString: string
        threeString: string

    for elem in fivelem:
        if result['e'] notin elem:
            # we rule out 2
            var passed = true
            for tempx in twoelem:
                if tempx notin elem:
                    passed = false
            
            if passed:
                # its a 3
                threeString = elem
            else:
                # its a 5
                fiveString = elem
    
    for x in threeString:
        if x notin fiveString:
            result['c'] = x
            solved.add x
        else:
            if x in twoelem:
                result['f'] = x
                solved.add x

    echo fmt"c = {result['c']}"
    echo fmt"f = {result['f']}"

proc getValue(valstr: string, table: Table[char, char]): int =
    # echo table
    var
        active: seq[char]
    for x in valstr:
        active.add x
    
    
    # echo fmt"ACTIVE IS {active}"

    for i in 0..len(active)-1:
        for key in table.keys:
            if table[key] == active[i]:
                # echo fmt"{active[i]} {key}"
                active[i] = key
                break

    active.sort()
    # echo fmt"TRANSLATED ACTIVE IS {active}"
    
    for key in keycodes.keys:
        if keycodes[key] == active.join:
            return key


for line in lines:
    echo "==== solving new line ===="
    if line == "": continue
    var 
        nstr = line.replace(" | ", " ")
        narr = nstr.split(" ")
        arr = line.split(" | ")
        outputArr = arr[1].split(" ")
        tempresult = ""
        translationTable = solveLine(narr)

    # echo translationTable
    # echo outputArr

    for x in outputArr:
        var
            val = getValue(x, translationTable)

        tempresult.add fmt"{val}"
    
    result += parseInt(tempresult)

echo result
