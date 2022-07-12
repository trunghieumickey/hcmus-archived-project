from copy import deepcopy as copy

#check empty board
def isEmpty(MainPathFinder):
    for i in range (MainPathFinder.ui.gridNum):
        for j in range (MainPathFinder.ui.gridNum):
            if MainPathFinder.ui.getState(i,j) != 0:
                return False
    return True

def heuristic(board):
    gridNum = len(board)
    max_1,max_2,player_3_1,player_3_2,player_4_1,player_4_2 = [0]*6
    for i in range(gridNum):
        player_1_1,player_1_2,player_2_1,player_2_2 = [0]*4
        for j in range(gridNum):
            if board[i][j] == 1:
                player_1_1 += 1
            if board[i][j] == 2:
                player_1_2 += 1
            if board[j][i] == 1:
                player_2_1 += 1
            if board[j][i] == 2:
                player_2_2 += 1
        if player_1_1 == 0:
            max_2 = max(max_2, player_1_2)
        if player_1_2 == 0:
            max_1 = max(max_1, player_1_1)
        if player_2_1 == 0:
            max_2 = max(max_2, player_2_2)
        if player_2_2 == 0:
            max_1 = max(max_1, player_2_1)

        if board[i][i] == 1:
            player_3_1 += 1
        if board[i][i] == 2:
            player_3_2 += 1
        if board[i][gridNum-i-1] == 1:
            player_4_1 += 1
        if board[i][gridNum-i-1] == 2:
            player_4_2 += 1
    if player_3_1 == 0:
        max_2 = max(max_2, player_3_2)
    if player_3_2 == 0:
        max_1 = max(max_1, player_3_1)
    if player_4_1 == 0:
        max_2 = max(max_2, player_4_2)
    if player_4_2 == 0:
        max_1 = max(max_1, player_4_1)

    if max_1 == gridNum: max_2 = 0
    elif max_2 == gridNum: max_1 = 0
    return max_2 - max_1

def isDone(MainPathFinder, board, isBot):
    done = True
    #Bot turn
    if isBot:
        for i in range (MainPathFinder.ui.gridNum):
            done = True
            for j in range (MainPathFinder.ui.gridNum):
                if board[i][j] != 2:
                    done = False
                    break
            if done:
                return 1

        for i in range (MainPathFinder.ui.gridNum):
            done = True
            for j in range (MainPathFinder.ui.gridNum):
                if board[j][i] != 2:
                    done = False
                    break
            if done:
                return 1

        done = True
        for i in range (MainPathFinder.ui.gridNum):
            if board[i][i] != 2:
                done = False
                break
        if done:
            return 1
        done = True
        for i in range (MainPathFinder.ui.gridNum):
            if board[i][MainPathFinder.ui.gridNum-i-1] != 2:
                done = False
                break
        if done:
            return 1
    
    #Player turn 
    else:
        for i in range (MainPathFinder.ui.gridNum):
            done = True
            for j in range (MainPathFinder.ui.gridNum):
                if board[i][j] != 1:
                    done = False
                    break
            if done:
                return -1

        for i in range (MainPathFinder.ui.gridNum):
            done = True
            for j in range (MainPathFinder.ui.gridNum):
                if board[j][i] != 1:
                    done = False
                    break
            if done:
                return -1

        done = True
        for i in range (MainPathFinder.ui.gridNum):
            if board[i][i] != 1:
                done = False
                break
        if done:
            return -1
        done = True
        for i in range (MainPathFinder.ui.gridNum):
            if board[i][MainPathFinder.ui.gridNum-i-1] != 1:
                done = False
                break
        if done:
            return -1
    
    #Not done
    for i in range (MainPathFinder.ui.gridNum):
        for j in range (MainPathFinder.ui.gridNum):
            if board[i][j] == 0:
                return -2
    
    #Tie
    return 0


def isFinal(board):
    gridNum = len(board)
    #Check bot win
    for i in range (gridNum):
        done = True
        for j in range (gridNum):
            if board[i][j] != 2:
                done = False
                break
        if done:
            return 1

    for i in range (gridNum):
        done = True
        for j in range (gridNum):
            if board[j][i] != 2:
                done = False
                break
        if done:
            return 1

    done = True
    for i in range (gridNum):
        if board[i][i] != 2:
            done = False
            break
    if done:
        return 1
    done = True
    for i in range (gridNum):
        if board[i][gridNum-i-1] != 2:
            done = False
            break
    if done:
        return 1

    #Check player win
    for i in range (gridNum):
        done = True
        for j in range (gridNum):
            if board[i][j] != 1:
                done = False
                break
        if done:
            return -1

    for i in range (gridNum):
        done = True
        for j in range (gridNum):
            if board[j][i] != 1:
                done = False
                break
        if done:
            return -1

    done = True
    for i in range (gridNum):
        if board[i][i] != 1:
            done = False
            break
    if done:
        return -1
    done = True
    for i in range (gridNum):
        if board[i][gridNum-i-1] != 1:
            done = False
            break
    if done:
        return -1
    
    #Not done
    for i in range (gridNum):
        for j in range (gridNum):
            if board[i][j] == 0:
                return -2
    
    #Tie
    return 0
    
              
def BestMove(MainPathFinder, max_depth, type):
    int_max_depth = int(max_depth)
    board = copy(MainPathFinder.ui.state)
    if isEmpty(MainPathFinder):
        MainPathFinder.ui.setState(0,0,2)
        return
    
    value, temp, x, y = -3, 0, -1, -1
    for i in range(MainPathFinder.ui.gridNum):
        for j in range(MainPathFinder.ui.gridNum):
            if board[i][j] == 0:
                board[i][j] = 2
                if type == 0:
                    #Minimax algorithm
                    temp = MinMax(MainPathFinder, board, False, 0, int_max_depth)

                else:
                    #Alpha-Beta algorithm
                    temp = AlphaBeta(MainPathFinder, board, int_max_depth, float('-inf'), float('inf'), False)

                board[i][j] = 0
                if temp > value:
                    x, y = i, j
                    value = temp
    if x == -1: return            
    MainPathFinder.ui.setState(x,y,"O")
    
#MinMax algorithm
def MinMax(MainPathFinder, board, isBot, depth, max_depth):
    temp = isDone(MainPathFinder, board, not isBot)
    if (temp != -2 ):
        return temp
    
    if (depth == max_depth):
        temp = heuristic(board)
        return temp
    depth += 1
        
    if isBot:
        value = -2
        for i in range (MainPathFinder.ui.gridNum):
            for j in range (MainPathFinder.ui.gridNum):
                if board[i][j] == 0:
                    board[i][j] = 2
                    temp = MinMax(MainPathFinder, board, not isBot, depth, max_depth)
                    board[i][j] = 0
                    if temp > value:
                        value = temp
    else:
        value = 2
        for i in range (MainPathFinder.ui.gridNum):
            for j in range (MainPathFinder.ui.gridNum):
                if board[i][j] == 0:
                    board[i][j] = 1
                    temp = MinMax(MainPathFinder, board, not isBot, depth, max_depth)
                    board[i][j] = 0
                    if temp < value:
                        value = temp

    return value

#Alpha-Beta algorithm
def AlphaBeta(MainPathFinder , board, depth, alpha, beta, isBot):
    gridNum = len(board)
    if depth == 0 or isDone(MainPathFinder,board, not isBot) != -2:
        return heuristic(board)

    if isBot:
        value = float('-inf')
        for i in range (gridNum):
            for j in range (gridNum):
                if board[i][j] == 0:
                    board[i][j] = 2
                    value =  max(value, AlphaBeta(MainPathFinder, board, depth-1, alpha, beta, not isBot))
                    board[i][j] = 0
                    if value >= beta:
                        break
                    alpha = max(alpha, value)
        return value

    else:
        value = float('inf')
        for i in range (gridNum):
            for j in range (gridNum):
                if board[i][j] == 0:
                    board[i][j] = 1
                    value = min(value, AlphaBeta(MainPathFinder,board, depth-1, alpha, beta, not isBot))
                    board[i][j] = 0
                    if value <= alpha:
                        break
                    beta = min(beta, value)
        return value
                    