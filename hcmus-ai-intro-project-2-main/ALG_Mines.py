from pysat.solvers import Solver
from pysat.card import *
from typing import List, Set
from itertools import combinations

#Convert the position on the map of a node to the position in the list of the index
def MaptoIndex(x, y, width):
    return (x + y * width) + 1

#Return the list of all the sourrounding index and itself of a particular index
def Surround_Index(x, y, width, height):
    index = []
    for i in range(x-1, x+2):
        for j in range(y-1, y+2):
            if i >= 0 and i < width and j >= 0 and j < height:
                index.append(MaptoIndex(i, j, width))
    return index

#Convert the index from the list to its position on the map
def Index_to_Map(index, width):
    value = -1 if index < 0 else 1
    index = abs(index) - 1
    y = index // width
    x = index % width
    return x, y, value

#Return the list of the numbered index
def index_list(map):
    index_list = []
    for i in range(len(map)):
        for j in range(len(map[0])):
            if map[i][j] != -1:
                index_list.append((i, j))
    return index_list

#Check if the map is done
def isDone(map, drawn_map, indexList):
    for i in indexList:
        count = 0
        for j in range(i[0] -1, i[0] + 2):
            for k in range(i[1] -1, i[1] + 2):
                if j >= 0 and j < len(map) and k >= 0 and k < len(map[0]):
                    if drawn_map[j][k] == 1:
                        count += 1
                    if count > map[i[0]][i[1]]:
                        return False
        if count != map[i[0]][i[1]]:
            return False
    return True

#Return the clorable index
def colorable(map):
    legal = []
    for i in range(len(map)):
        for j in range(len(map[0])):
            if map[i][j] != -1 and (i,j) not in legal:
                legal.append((i, j))
            else:
                for k in range(i-1, i+2):
                    for l in range(j-1, j+2):
                        if k >= 0 and k < len(map) and l >= 0 and l < len(map[0]):
                            if map[k][l] != -1 and (i, j) not in legal:
                                legal.append((i, j))
    return legal

#check if the surrounding is legal
def check_surrounding (x, y, map, drawn_map):
    for i in range(x-1, x+2):
        for j in range(y-1, y+2):
            if i >= 0 and i < len(map) and j >= 0 and j < len(map[0]):
                if map[i][j] != -1:
                    count = 0
                    for k in range(i-1, i+2):
                        for l in range(j-1, j+2):
                            if k >= 0 and k < len(map) and l >= 0 and l < len(map[0]):
                                if drawn_map[k][l] == 1:
                                    count += 1
                    if count == map[i][j]:
                        return False
    return True

#CNF algorithm ##########################################################################
def generateClauses(value, surrounding):
    clauses = []
    for true_Set in combinations(surrounding, value):
        false_Set = list(set(surrounding) - set(true_Set))
        for item in true_Set: 
            clauses.append([item] + false_Set)
        for item in false_Set: 
            clauses.append([-item] + [-i for i in true_Set])
    return clauses

def CNF_Clauses(map, width, height):
    clauses = []
    for i in range(0, height):
        for j in range(0, width):
            if map[i][j] > -1:
                temp=Surround_Index(j, i, width, height)
                clauses += generateClauses(map[i][j], temp)
    
    res = []
    for i in clauses:
        if set(i) not in res: res.append(set(i))
    return res

def Cnf_pysat(MainWindow):
    width = MainWindow.width
    height = MainWindow.height
    map = MainWindow.number

    clauses = CNF_Clauses(map, width, height)
    solver = Solver(name='gc3')
    for i in clauses: solver.add_clause([int(k) for k in i])

    if solver.solve():
        Index_list = solver.get_model()
        for i in Index_list:
                x, y, value = Index_to_Map(i, width)
                if value == 1:
                    MainWindow.setState(y, x, True)
                else:
                    MainWindow.setState(y, x, False)
    
    else: print("No solution")

#Brute force algorithm ##########################################################################
def brute_force_loop(drawn_map, map, legal, index, indexList):
    if index == len(legal): 
        return isDone(map, drawn_map, indexList), drawn_map
    
    for color in range(2):
        drawn_map[legal[index][0]][legal[index][1]] = color
        if brute_force_loop(drawn_map, map, legal, index + 1, indexList)[0]:
            return True, drawn_map

    return False, drawn_map
        
def brute_force(MainWindow):
    width = MainWindow.width
    height = MainWindow.height
    map = MainWindow.number

    drawn_map = [[0 for i in range(width)] for j in range(height)]
    legal = colorable(map)
    indexList = index_list(map)
    
    temp, drawn_map = brute_force_loop(drawn_map, map, legal, 0, indexList)
    if (not temp):
        print("No Solution")

    for i in range(height):
        for j in range(width):
            if drawn_map[i][j] == 1:
                MainWindow.setState(i, j, True)
            else:
                MainWindow.setState(i, j, False)

#backtracking algorithm ##########################################################################

def backtracking_loop(drawn_map, map, legal, index, indexList):
    if index == len(legal):
        if isDone(map, drawn_map, indexList):
            return True, drawn_map
        return False, drawn_map

    if check_surrounding(legal[index][0], legal[index][1], map, drawn_map):
        drawn_map[legal[index][0]][legal[index][1]] = 1
        temp, drawn_map  = backtracking_loop(drawn_map, map, legal, index+1, indexList)
        if temp:
            return True, drawn_map

        drawn_map[legal[index][0]][legal[index][1]] = 0

    temp, drawn_map = backtracking_loop(drawn_map, map, legal, index+1, indexList)
    if temp:
        return True, drawn_map
    
    return False, drawn_map


def backtracking(MainWindow):
    width = MainWindow.width
    height = MainWindow.height
    map = MainWindow.number

    drawn_map = [[0 for i in range(width)] for j in range(height)]
    legal = colorable(map)
    indexList = index_list(map)

    temp, drawn_map  = backtracking_loop(drawn_map, map, legal, 0, indexList)
    if (not temp):
        print("No Solution")

    for i in range(height):
        for j in range(width):
            if drawn_map[i][j] == 1:
                MainWindow.setState(i, j, True)
            else:
                MainWindow.setState(i, j, False)

            





