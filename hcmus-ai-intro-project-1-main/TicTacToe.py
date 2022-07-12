from UI_TicTacToe import UI_TicTacToe
from UI_Window import gameWindow
from ALG_TicTacToe import *


depth = [1]
nerf_depth = [0]
#type to switch between Minimax and AlphaBeta (0 for Minimax, 1 for AlphaBeta)
type = [0]
board = [3]

def Listener(x,y):
    if (x != "Noff" and y != "Noff"):
        MainPathFinder.ui.setState(x,y,"X")
    BotListener()

def BotListener():
    #3x3
    if MainPathFinder.ui.gridNum == 3:
        depth[0] = 8
        BestMove(MainPathFinder, depth[0], type[0])
    #5x5
    elif MainPathFinder.ui.gridNum == 5:
        BestMove(MainPathFinder, depth[0], type[0])
        depth[0] += 0.5
    #7x7
    elif MainPathFinder.ui.gridNum == 7:
        BestMove(MainPathFinder, depth[0], type[0])
        nerf_depth[0] += 0.25
        if int(nerf_depth[0]) == 1: 
            depth[0] += 0.5
            nerf_depth[0] = 0
    
    #Check if game is over
    check = isFinal(board = copy(MainPathFinder.ui.state))
    if check != 2:
        match(check):
            case 0:
                MainPathFinder.ui.setVictory(0)
            case -1:
                MainPathFinder.ui.setVictory(1)
            case 1:
                MainPathFinder.ui.setVictory(2)


MainPathFinder = gameWindow(UI_TicTacToe,board[0],Listener)
MainPathFinder.execute()