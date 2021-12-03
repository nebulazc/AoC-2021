open("input.txt") do file
    lines = readlines(file)

    gamma = Array{String}(undef, length(lines[1]))
    epsilon = Array{String}(undef, length(lines[1]))

    for i in 1:length(lines[1])
        zeroCount = 0
        oneCount = 0
        for j in 1:length(lines)
            val = lines[j][i]
            println(val, " ", typeof(val))
            if val == '1'
                oneCount += 1
                println("seeing 1")
            elseif val == '0'
                zeroCount += 1
                println("seeing 0")
            end
        end
        println(zeroCount, " ", oneCount)
        if zeroCount > oneCount
            global gamma[i] = "0"
            global epsilon[i] = "1"
        else
            global gamma[i] = "1"
            global epsilon[i] = "0"
        end

    end

    gammaBinStr = join(gamma)
    epsilonBinStr = join(epsilon)
    println(gammaBinStr, typeof(gammaBinStr))
    println(epsilonBinStr, typeof(gammaBinStr))


    gammaVal = parse(Int, gammaBinStr, base=2)
    epsilonVal = parse(Int64, epsilonBinStr, base=2)

    println(gammaVal * epsilonVal)

end
