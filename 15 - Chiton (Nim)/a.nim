import sequtils, strutils, strformat, algorithm, math, tables, sets

type
    Coord = tuple[row, column : int]

    Edge  = tuple[
        value  : int,
        start  : Coord,
        target : Coord]
    
    Graph = object
        vertices  : HashSet[Coord]
        neighbours: Table[Coord, seq[ tuple[target: Coord, cost: int] ]]

proc createGraph(edges: seq[Edge]) : Graph = 
    for (value, start, target) in edges:
        result.vertices.incl start
        result.vertices.incl target
        result.neighbours.mgetOrPut(start, @[]).add( (target, value) )

proc dijkstra(graph : Graph, start, target: Coord) : (seq[Coord], int) = 
    var
        dist = initTable[Coord, int]()
        prev = initTable[Coord, Coord]()
        notSeen = graph.vertices

    for v in graph.vertices:
        dist[v] = 999999
    dist[start] = 0

    while len(notSeen) > 0:
        var
            vertex1: Coord
            minDist = 999999
        
        for vertex in notSeen:
            if dist[vertex] < minDist:
                vertex1 = vertex
                minDist = dist[vertex]
            
        notSeen.excl vertex1

        for (vertex2, cost) in graph.neighbours[vertex1]:
            let
                alt = dist[vertex1] + cost
            if alt < dist[vertex2]:
                dist[vertex2] = alt
                prev[vertex2] = vertex1

    var
        vertex = target

    while true:
        result[0].add vertex
        vertex = prev[vertex]
        echo vertex
        if vertex == (0, 0): break

    result[0].reverse()
    result[1] = dist[target]

const
    offsets = [(1,0), (-1,0), (0,1), (0,-1)]

let
    file = readFile("testinput")
    lines = file.splitLines()

var a: seq[Edge]
let
    rows = toSeq(0..len(lines)-1)
    cols = toSeq(0..len(lines[0])-1)

for i in 0..len(lines)-1:
    for j in 0..len(lines[0])-1:
        for offset in offsets:
            # echo fmt"{i} {j} {offset}"
            if i+offset[1] in rows and j+offset[0] in cols:
                a.add (parseInt(fmt"{lines[i][j]}"),
                       (row : i,
                        column : j),
                       (row : i+offset[1],
                        column : j+offset[0]))


let graph = createGraph(a)
let path = dijkstra(graph, (0,0), (len(lines)-1, len(lines[0])-1))
# echo path
for i in 0..len(lines)-1:
    for j in 0..len(lines[0])-1:
        if (i,j) in path[0]:
            stdout.write "█"
        else:
            stdout.write "."
    stdout.write "\n"
echo path[1]