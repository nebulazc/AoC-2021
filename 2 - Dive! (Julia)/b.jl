horizontal = 0
depth = 0
aim = 0

open("input") do file
    lines = readlines(file)
    for line in lines
        command, value = split(line, " ")
        value = parse(Int64, value)
        if command == "forward"
            global horizontal += value
            global depth += aim * value
        elseif command == "up"
            global aim -= value
        elseif command == "down"
            global aim += value
        end
    end
end
println(horizontal * depth)
