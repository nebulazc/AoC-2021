inputs = []
tables = []

BingoElement = Struct.new(:value, :checked)

file_open = File.open("input")
file_data = file_open.read
file_lines = file_data.split("\n")

inputs = file_lines[0]

$bingo_table_height = 5
$bingo_table_width = 5

# initialize tables
temp = []
file_lines.each do |line|
    if line == ""
        next
    elsif line.split(",").length() > 6
        inputs = line.split(",")
    else
        x = line.split(" ")
        nx = []
        x.each do |elem|
            nx.push(BingoElement.new(Integer(elem), false))
        end
        temp.push(nx)
        if temp.length() == $bingo_table_height
            tables.push(temp)
            temp = []
        end
    end
end


def updateTables(tables, value)
    value = Integer(value)
    tables.each do |table|
        table.each do |row|
            row.each do |element|
                if element.value == value
                    element.checked = true
                end
            end
        end
    end
end

def checkWin(table)
    # row check
    (0..$bingo_table_height - 1).each do |row|
        won = true
        (0..$bingo_table_width - 1).each do |col|
            if table[row][col].checked == false
                won = false
            end
        end

        if won == true
            return true
        end
    end

    # column check
    (0..$bingo_table_height - 1).each do |col|
        won = true
        (0..$bingo_table_width - 1).each do |row|
            if table[row][col].checked == false
                won = false
            end
        end

        if won == true
            return true
        end
    end
end

def getAnswer(table, latestInput)
    sumOfUnmarked = 0

    table.each do |row|
        row.each do |elem|
            if elem.checked == false
                sumOfUnmarked += elem.value
            end
        end
    end

    puts "ANSWER #{sumOfUnmarked * Integer(latestInput)} #{latestInput}"
end

inputs.each do |input|
    updateTables(tables, input)
    tables.each do |table|
        if checkWin(table) == true 
            puts "WON"
            getAnswer(table, input)
            exit 0
        end
    end
end

puts tables[0]
