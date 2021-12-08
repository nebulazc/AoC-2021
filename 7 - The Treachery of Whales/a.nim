import strutils, sequtils, strformat, algorithm, math

let
    file = readFile("input")
    crabs = file.split(",").mapIt(parseFloat(it))


var
    sortedCrabs = crabs
    median: float
    first: float
    second: float

sortedCrabs.sort(system.cmp)

var i = len(sortedCrabs)
if i mod 2 == 0:
    var
        first = sortedCrabs[int(floor(i/2))]
        second = sortedCrabs[int(floor((i-1)/2))]

    median = (first + second) * 0.5
else:
    median = sortedCrabs[int(floor(i/2))]

echo first
echo second
echo median

var result: float = 0

for crab in sortedCrabs:
    result += abs(crab - median)

echo result