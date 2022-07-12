from UI_PathFinder import UI_PathFinder
from UI_Window import gameWindow
from ALG_PathFinder import *

def Readfile(width, height, Start_Goal, n_obstacle, k, obstacle):
    A, B= [], []
    with open("input.txt","r") as f:
        A = f.readline().split()
        width = int(A[0])
        height = int(A[1])
        B = f.readline().split()
        for i in range(len(B)):
            Start_Goal.append(int(B[i])) 
        k = int(f.readline())
        n_obstacle = int(f.readline())
        C,obstacle = [0]*n_obstacle, [0]*n_obstacle
        for i in range(n_obstacle):
            C[i] = f.readline().split()
            obstacle[i] = [0]*len(C[i])
            for j in range(len(C[i])):
                obstacle[i][j] = int(C[i][j])
    return width, height, Start_Goal, n_obstacle, k, obstacle

def Writefile(Pathlength,expandLength):
    with open("output.txt","w") as f:
        if Pathlength == -1:
            f.write("No Solution to find the path")
        else:
            f.write("Cost of the path: " + str(Pathlength) + "\n")
        f.write("Number of nodes expanded: " + str(expandLength) + "\n")

if __name__ == "__main__":
    width, height, n_obstacle, k = 0,0,0,0
    Start_Goal, obstacle = [],[]
    width, height, Start_Goal, n_obstacle, k, obstacle = Readfile(width, height, Start_Goal, n_obstacle, k, obstacle)
    MainPathFinder = gameWindow(UI_PathFinder,width,height)
    MainPathFinder.ui.setStatePoint(Start_Goal[0],Start_Goal[1],"Start")
    MainPathFinder.ui.setStatePoint(Start_Goal[2],Start_Goal[3],"Goal")
    for i in range(n_obstacle):
        MainPathFinder.ui.setStatePoligon(obstacle[i], "Obstacle")
    match k:
        case 0:
            path,expandLength = BFS(MainPathFinder,[Start_Goal[0],Start_Goal[1]],[Start_Goal[2],Start_Goal[3]])
            if path != False:
                Pathlength = len(path)
            Writefile(Pathlength,expandLength)
        case 1:
            path,expandLength = UCS(MainPathFinder,[Start_Goal[0],Start_Goal[1]],[Start_Goal[2],Start_Goal[3]])
            if path != False:
                Pathlength = len(path)
            Writefile(Pathlength,expandLength)
        case 2:
            path,expandLength = IDS(MainPathFinder,[Start_Goal[0],Start_Goal[1]],[Start_Goal[2],Start_Goal[3]])
            if path != False:
                Pathlength = len(path)
            Writefile(Pathlength,expandLength)
        case 3:
            path,expandLength = GBFS(MainPathFinder,[Start_Goal[0],Start_Goal[1]],[Start_Goal[2],Start_Goal[3]])
            if path != False:
                Pathlength = len(path)
            Writefile(Pathlength,expandLength)
        case 4:
            path,expandLength = AStar(MainPathFinder,[Start_Goal[0],Start_Goal[1]],[Start_Goal[2],Start_Goal[3]])
            if path != False:
                Pathlength = len(path)
            Writefile(Pathlength,expandLength)
    MainPathFinder.execute()
