import heapq

def expandNode(MainPathFinder, queue:list, current:list, alg, allowDiagonal = True):
    MainPathFinder.ui.setStatePoint(current[0],current[1],"Expanded")
    pos = []
    pos.append([current[0]+1, current[1]])
    pos.append([current[0], current[1]+1])
    pos.append([current[0]-1, current[1]])
    pos.append([current[0], current[1]-1])
    if (allowDiagonal):
        pos.append([current[0]+1, current[1]+1])
        pos.append([current[0]-1, current[1]+1])
        pos.append([current[0]-1, current[1]-1])
        pos.append([current[0]+1, current[1]-1])
    for i in range(len(pos)):
        state = MainPathFinder.ui.getState(pos[i][0], pos[i][1]) 
        if state == "Obstacle" or not (i<4 or pos[i%4] or pos[(i+1)%4]):
            pos[i] = False
        elif state == "Goal" and alg != 2:
            return "Goal",pos[i]
    for i in range(len(pos)):
        if alg == 1 and pos[i] and (MainPathFinder.ui.getState(pos[i][0], pos[i][1]) != "Path" or pos[i] in queue):
            pos[i] = False
        elif alg != 1 and pos[i] and pos[i] in queue:
            pos[i] = False
    try:
        while True:
            pos.remove(False)
    except:
        pass
    return pos

def bresenham(x0, y0, x1, y1):
    ans = []
    dx = x1 - x0
    dy = y1 - y0
    xsign = 1 if dx > 0 else -1
    ysign = 1 if dy > 0 else -1
    dx = abs(dx)
    dy = abs(dy)
    if dx > dy:
        xx, xy, yx, yy = xsign, 0, 0, ysign
    else:
        dx, dy = dy, dx
        xx, xy, yx, yy = 0, ysign, xsign, 0
    D = 2*dy - dx
    y = 0
    for x in range(dx + 1):
        ans.append([x0 + x*xx + y*yx, y0 + x*xy + y*yy])
        if D >= 0:
            y += 1
            D -= 2*dx
        D += 2*dy
    return ans


#Euclidean Distance for path cost
def pithagonal(x1,y1,x2,y2):
    return int(((x1-x2)**2 + (y1-y2)**2)**0.5)

#Manhatten Distance between two points(heuristic)
def Mahattan(x1,y1,x2,y2):
    return abs(x1-x2) + abs(y1-y2)

def BFS(MainPathFinder, start:list, goal:list):
    count = 0
    if start == goal:
        return [start], 0
    queue,queuePath = [start],[[start]]
    while queue:
        current,path = queue.pop(0),queuePath.pop(0)
        count += 1
        pos = expandNode(MainPathFinder, queue, current, 1)
        if pos:
            if pos[0] == "Goal":
                path.append(pos[1])
                MainPathFinder.ui.setStatePoint(path[0][0],path[0][1],"Start")
                for i in range(1,len(path)-1):
                    MainPathFinder.ui.setStatePoint(path[i][0],path[i][1],"Waypoint")
                return path,count
            else:
                for i in pos:
                    queue.append(i)
                    queuePath.append(path+[i])
    return False,count

def UCS(MainPathFinder, start:list, goal:list):
    count = 0
    if start == goal:
        return [start], 0
    queue = [(0,start, [start])]
    while queue:
        removed = False
        cost = queue[0][0]
        path = queue[0][2]
        current = heapq.heappop(queue)[1]
        count+=1
        if current == goal:
            MainPathFinder.ui.setStatePoint(path[0][0],path[0][1],"Start")
            for i in range(1,len(path)-1):
                MainPathFinder.ui.setStatePoint(path[i][0],path[i][1],"Waypoint")
            MainPathFinder.ui.setStatePoint(path[-1][0],path[-1][1],"Goal")
            return path,count
        pos = expandNode(MainPathFinder, path, current, 2)
        for i in queue:
            for j in pos:
                if i[1] == j:
                    if i[0] > cost + pithagonal(j[0],j[1],start[0],start[1]):
                        queue.remove(i)
                        removed = True
                        break
                    else:
                        pos.remove(j)
        if removed:heapq.heapify(queue)

        if pos:
            for i in pos:
                heapq.heappush(queue, (cost + pithagonal(i[0],i[1],start[0],start[1]),i, path+[i]))
    return False,count

def DLS(MainPathFinder, start:list, goal:list, depth):
    count = 0
    if start == goal:
        return [start], [start], 0
    if depth == 0:
        return False, [], 0
    expanded = []
    stack, stackPath, stackLimit = [start], [[start]], [0]
    while stack:
        current, path, limit = stack.pop(), stackPath.pop(), stackLimit.pop()
        count += 1
        expanded.append(current)
        if limit <= depth:
            pos = expandNode(MainPathFinder, expanded, current, 0)
            for i in path:
                for j in pos:
                    if i[1] == j:
                        pos.remove(j)
            if pos:
                if pos[0] == "Goal":
                    path.append(pos[1])
                    return path, expanded,count
                else:
                    for i in pos:
                        stack.append(i)
                        stackPath.append(path+[i])
                        stackLimit.append(limit+1)
    for i in expanded:
        MainPathFinder.ui.setStatePoint(i[0],i[1],"Path")
    return False, expanded,count

def IDS(MainPathFinder, start:list, goal:list):
    current_count,count,limit = 0, 0, 0
    expanded = []
    temp = []
    while True:
        path, temp,count = DLS(MainPathFinder, start, goal, limit)
        current_count += count
        for i in temp:
            if i not in expanded:
                expanded.append(i)

        if path:
            for i in expanded:
                MainPathFinder.ui.setStatePoint(i[0],i[1],"Expanded")
            MainPathFinder.ui.setStatePoint(path[0][0],path[0][1],"Start")
            for i in range(1,len(path)-1):
                MainPathFinder.ui.setStatePoint(path[i][0],path[i][1],"Waypoint")
            return path,current_count
        limit += 1
        temp = []



def GBFS(MainPathFinder, start:list, goal:list):
    count = 0
    if start == goal:
        return [start], 0
    queue = [(Mahattan(start[0],start[1],goal[0],goal[1]),start, [start])]
    while queue:
        path = queue[0][2]
        current = heapq.heappop(queue)[1]
        count += 1
        pos = expandNode(MainPathFinder, path, current, 0)
        for i in queue:
            for j in pos:
                if i[1] == j:
                    pos.remove(j)
        if pos:
            if pos[0] == "Goal":
                path.append(pos[1])
                MainPathFinder.ui.setStatePoint(path[0][0],path[0][1],"Start")
                for i in range(1,len(path)-1):
                    MainPathFinder.ui.setStatePoint(path[i][0],path[i][1],"Waypoint")
                return path,count
            else:
                for i in pos:
                    heapq.heappush(queue, (Mahattan(i[0],i[1],goal[0],goal[1]),i, path+[i]))
    return False,count

def AStar(MainPathFinder, start:list, goal:list):
    count = 0
    if start == goal:
        return [start], 0
    queue = [(Mahattan(start[0],start[1],goal[0],goal[1]),start, [start])]
    while queue:
        removed = False
        cost = queue[0][0]
        path = queue[0][2]
        current = heapq.heappop(queue)[1]
        count += 1
        if current == goal:
            MainPathFinder.ui.setStatePoint(path[0][0],path[0][1],"Start")
            for i in range(1,len(path)-1):
                MainPathFinder.ui.setStatePoint(path[i][0],path[i][1],"Waypoint")
            MainPathFinder.ui.setStatePoint(path[-1][0],path[-1][1],"Goal")
            return path,count
        cost -= Mahattan(current[0],current[1],goal[0],goal[1])
        pos = expandNode(MainPathFinder, path, current, 2)
        for i in queue:
            for j in pos:
                if i[1] == j:
                    if i[0] > cost + pithagonal(j[0],j[1],start[0],start[1]) + Mahattan(j[0],j[1],goal[0],goal[1]):
                        queue.remove(i)
                        removed = True
                        break
                    else:
                        pos.remove(j)
        if removed: heapq.heapify(queue)

        if pos:
            for i in pos:
                heapq.heappush(queue, (cost + pithagonal(i[0],i[1],start[0],start[1]) + Mahattan(i[0],i[1],goal[0],goal[1]),i, path+[i]))
    return False,count
