import sequtils, strutils, strformat, math, algorithm, tables, hashes, sets, bitops

const
    filename = "testinput3"
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



proc solve(str : string) : (string, string, int64) =
    if '1' notin str:
        return (str, "", int64(0))

    var
        c         : int64 = 0
        readBits  : string
        remainder : string

    proc readBit() : char = 
        result = str[c]
        readBits.add str[c]
        remainder = str[c+1..len(str)-1]
        c += 1


    var
        packetVersionStr   : string
        packetTypeIDStr    : string
        totalPacketVersion : int64

    for _ in 0..2:
        packetVersionStr.add readBit()
    for _ in 3..5:
        packetTypeIDStr.add readBit()

    let
        packetVersion = fromBin[int](packetVersionStr)
        packetTypeID = fromBin[int](packetTypeIDStr)

    totalPacketVersion.inc packetVersion

    if packetTypeID == 4:
        # packet is a literal value
        var
            literalValueStr: string
            slice          : string
            c              : int = 0
            b              : char
 
        while true:
            b = readBit()
            slice.add b
            if c == 4:
                c = -1
                literalValueStr.add slice[1..4]
                if slice[0] == '0':
                    break
                slice = ""
            inc c 

        echo "lit ", literalValueStr
        let
            literalValue = fromBin[int](literalValueStr)
    else:
        # operator
        let 
            lengthTypeIDStr = readBit()
        
        echo fmt"lengthtypeidstr {lengthTypeIDStr}"

        if lengthTypeIDStr == '1':
            var
                numberOfSubpacketsStr : string
                numberOfSubpackets    : int
            for _ in 1..11:
                numberOfSubpacketsStr.add readBit()

            numberOfSubpackets = fromBin[int](numberOfSubpacketsStr)
            let subresult = solve(remainder)
            totalPacketVersion += subresult[2]

        else:
            var
                lengthOfSubpacketsStr : string
                lengthOfSubpackets    : int
                subpacketStr          : string
            for _ in 1..15:
                lengthOfSubpacketsStr.add readBit()
            lengthOfSubpackets = fromBin[int](lengthOfSubpacketsStr)
            
            for _ in 1..lengthOfSubpackets:
                subpacketStr.add readBit()
            
            # echo subpacketStr
            let subresult = solve(subpacketStr)
            totalPacketVersion += subresult[2]


    # echo "packet ver ", packetVersion
    # echo "packet type id ", packetTypeID

    result = (readBits, remainder, totalPacketVersion)
    let subresult = solve(remainder)
    result[2] += subresult[2]
    echo result



for line in lines:
    if line == "": continue
    let binString = hexToBin(line)
    echo binString
    echo solve(binString)

