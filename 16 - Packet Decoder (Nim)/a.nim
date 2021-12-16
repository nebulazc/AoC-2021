import sequtils, strutils, strformat, math, algorithm, tables, hashes, sets, bitops

type
    Data = object
        readBits : string
        remainder : string
        version : int
        typeID : int
        lateralValue : int


const
    filename = "testinput2"
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



proc solve(str : string) : (string, string, int) =

    var
        c = 0
        readBits : string
        remainder : string
    proc readBit() : char = 
        result = str[c]
        readBits.add str[c]
        remainder = str[c+1..len(str)-1]
        inc c


    var
        packetVersionStr   : string
        packetTypeIDStr    : string
        totalPacketVersion : int

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
            echo "TODO THIS PART"
            # let
            #     numberOfSubpackets = fromBin[int](str[7..17])


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
            
            echo subpacketStr
            let subresult = solve(subpacketStr)
            totalPacketVersion.inc subresult[2]


    echo "packet ver ", packetVersion
    echo "packet type id ", packetTypeID

    result = (readBits, remainder, totalPacketVersion)



for line in lines:
    if line == "": continue
    let binString = hexToBin(line)
    echo binString
    echo solve(binString)

