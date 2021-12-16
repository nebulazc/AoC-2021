import sequtils, strutils, strformat, math, algorithm, tables, hashes, sets, bitops

const
    filename = "testinput"
    literalGroupSize = 5

let
    file = readFile(filename)
    lines = file.splitLines()

proc hexToBin(str : string) : string = 
    var parsedNumber: int
    for x in str:
        if x in HexDigits:
            parsedNumber = fromHex[int](fmt"{x}")
            result.add fmt"{toBin(parsedNumber, 4)}"

# proc splitPackets(str : string) : seq[string] =



proc solve(str : string) : void =
    let 
        packetVersionStr = str[0..2]
        packetTypeIDStr = str[3..5]

        packetVersion = fromBin[int](packetVersionStr)
        packetTypeID = fromBin[int](packetTypeIDStr)

    if packetTypeID == 4:
        # packet is a literal value
        var
            literalValueStr: string
            i = 0

        while true:
            let
                slice = str[6 + i*literalGroupSize .. 6 + i*literalGroupSize + literalGroupSize - 1]
                valStr = slice[1..4]
            if slice[0] == '0':
                break
            inc i

        echo literalValueStr
        let
            literalValue = fromBin[int](literalValueStr)
    else:
        # operator
        let 
            lengthTypeIDStr = str[6]
        
        if lengthTypeIDStr == '1':
            let
                numberOfSubpackets = fromBin[int](str[7..17])


        else:
            let
                lengthOfSubpackets = fromBin[int](str[7..21])
                subpacketStr = str[22..21+lengthOfSubpackets]
            
            echo subpacketStr



    echo packetVersion
    echo packetTypeID




for line in lines:
    if line == "": continue
    let binString = hexToBin(line)
    echo binString
    solve(binString)

