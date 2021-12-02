import sequtils, strutils

var
    file = readFile("input").splitLines()
    horizontal = 0
    depth = 0
    aim = 0


for line in file:
    if line == "": continue
    let
        command = split(line)
        direction = command[0]
        value = parseInt(command[1])
    if direction == "forward":
        inc(horizontal, value)
        inc(depth, aim * value)
    elif direction == "up":
        inc(aim, -value)
    elif direction == "down":
        inc(aim, value)

echo horizontal * depth        