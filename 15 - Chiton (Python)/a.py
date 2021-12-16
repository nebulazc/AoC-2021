from collections import namedtuple, deque
from pprint import pprint as pp
from sys import stdout

inf = float('inf')
Edge = namedtuple('Edge', ['start', 'end', 'cost'])
 
class Graph():
    def __init__(self, edges):
        self.edges = [Edge(*edge) for edge in edges]
        # print(dir(self.edges[0]))
        self.vertices = {e.start for e in self.edges} | {e.end for e in self.edges}
 
    def dijkstra(self, source, dest):
        assert source in self.vertices
        dist = {vertex: inf for vertex in self.vertices}
        previous = {vertex: None for vertex in self.vertices}
        dist[source] = 0
        q = self.vertices.copy()
        neighbours = {vertex: set() for vertex in self.vertices}
        for start, end, cost in self.edges:
            neighbours[start].add((end, cost))
            neighbours[end].add((start, cost))
 
        #pp(neighbours)
 
        while q:
            # pp(q)
            u = min(q, key=lambda vertex: dist[vertex])
            q.remove(u)
            if dist[u] == inf or u == dest:
                break
            for v, cost in neighbours[u]:
                alt = dist[u] + cost
                if alt < dist[v]:                                  # Relax (u,v,a)
                    dist[v] = alt
                    previous[v] = u
        #pp(previous)
        s, u = deque(), dest
        while previous[u]:
            s.appendleft(u)
            cost += dist[u]
            u = previous[u]
        s.appendleft(u)
        print(dist[dest])
        return s

offsets = [(0,1), (0,-1), (1,0), (-1,0)]

arr = []
with open("testinput.txt", "r") as f:
    lines = f.readlines()
    for i in range(len(lines)):
        lines[i] = lines[i].strip()
        for j in range(len(lines[0])):
            for offset in offsets:
                if i+offset[1] >= 0 and i+offset[1] <= len(lines)-1 and j+offset[0] >= 0 and j+offset[0] <= len(lines[0])-1:
                    arr.append( (f'{i},{j}', f'{i+offset[1]},{j+offset[0]}', int(lines[i+offset[1]][j+offset[0]])) )
graph = Graph(arr)

result = graph.dijkstra("0,0", f'{len(lines)-1},{len(lines[0])-1}')

# for i in range(100):
#     for j in range(100):
#         if f'{i},{j}' in result:
#             stdout.write("█")
#         else:
#             stdout.write(".")
#     stdout.write("\n")