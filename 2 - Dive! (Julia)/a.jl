horizontal = 0
depth = 0

open("input") do file
    lines = readlines(file)
    for line in lines
        command, value = split(line, " ")
        value = parse(Int64, value)
        if command == "forward"
            global horizontal += value
        elseif command == "up"
            global depth -= value
        elseif command == "down"
            global depth += value
        end
    end
end
println(horizontal * depth)
