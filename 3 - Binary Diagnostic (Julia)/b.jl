open("input.txt") do file

#     ==== OXYGEN =======

    lines = readlines(file)
    lines2 = lines
    newlength = length(lines)
    for i in 1:length(lines[1])
        onecount = 0
        zerocount = 0
        for j in 1:newlength
            if lines[j][i] == '1'
                onecount += 1
            elseif lines[j][i] == '0'
                zerocount += 1
            end
            j += 1
        end

        if onecount > zerocount
            mostcommon = '1'
        elseif zerocount > onecount
            mostcommon = '0'
        else
            mostcommon = '1'
        end
        filtered = filter( x -> x[i] == mostcommon, lines)
        lines = filtered

        if length(filtered) == 1
            break
        end
        newlength = length(filtered)
    end

    oxygenRating = parse(Int, lines[1], base=2)

# ===== CO2 SCRUBBER ==========
    newlength = length(lines2)
    for i in 1:length(lines2[1])
        onecount = 0
        zerocount = 0
        for j in 1:newlength
            if lines2[j][i] == '1'
                onecount += 1
            elseif lines2[j][i] == '0'
                zerocount += 1
            end
        end

        if onecount > zerocount
            leastcommon = '0'
        elseif zerocount > onecount
            leastcommon = '1'
        elseif zerocount == onecount
            leastcommon = '0'
        end
        filtered = filter( x -> x[i] == leastcommon, lines2)
        lines2 = filtered

        if length(filtered) == 1
            break
        end
        newlength = length(filtered)
    end

    co2rating = parse(Int, lines2[1], base=2)

    println(lines[1])
    println(lines2[1])

    println(oxygenRating)
    println(co2rating)

    println(co2rating * oxygenRating)

end
