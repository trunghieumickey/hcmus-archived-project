from PyQt6 import QtCore, QtWidgets
class UI_TicTacToe(object):
    def setupUi(self, gameWindow, gridNum:int, listener,baseSize = 80):
        noffHeight = 25
        self.listener = listener
        self.gridNum = gridNum
        self.state  = [[0]*gridNum for i in range(gridNum)]
        self.isVictory = False
        gameWindow.setObjectName("gameWindow")
        gameWindow.resize(baseSize*gridNum, baseSize*gridNum)
        gameWindow.setMinimumSize(QtCore.QSize(baseSize*gridNum, baseSize*gridNum+noffHeight))
        gameWindow.setMaximumSize(QtCore.QSize(baseSize*gridNum, baseSize*gridNum+noffHeight))
        self.mainWidget = QtWidgets.QWidget(gameWindow)
        self.mainWidget.setMinimumSize(QtCore.QSize(baseSize*gridNum, baseSize*gridNum+noffHeight))
        self.mainWidget.setMaximumSize(QtCore.QSize(baseSize*gridNum, baseSize*gridNum+noffHeight))
        self.mainWidget.setObjectName("mainWidget")
        self.noffButton = QtWidgets.QPushButton(self.mainWidget)
        self.noffButton.setGeometry(QtCore.QRect(0, baseSize*gridNum, baseSize*gridNum, noffHeight))
        self.noffButton.setObjectName("pushButton")
        self.noffButton.clicked.connect(lambda state,x="Noff",y="Noff": self.onButtonClicked(x,y))
        self.noffButton.raise_()
        self.pushButton = [[] for i in range(gridNum)]
        for i in range(gridNum):
            for j in range(gridNum):
                self.pushButton[i].append(QtWidgets.QPushButton(self.mainWidget))
                self.pushButton[i][j].setGeometry(QtCore.QRect(baseSize*j, baseSize*i, baseSize, baseSize))
                self.pushButton[i][j].setObjectName("pushButton")
                self.pushButton[i][j].clicked.connect(lambda state,x=i,y=j: self.onButtonClicked(x,y))
                self.pushButton[i][j].raise_()
        gameWindow.setCentralWidget(self.mainWidget)
        self.retranslateUi(gameWindow,gridNum)
        QtCore.QMetaObject.connectSlotsByName(gameWindow)

    def retranslateUi(self, gameWindow, gridNum:int):
        _translate = QtCore.QCoreApplication.translate
        gameWindow.setWindowTitle(_translate("gameWindow", "MainWindow"))
        for i in range(gridNum):
            for j in range(gridNum):
                self.pushButton[i][j].setText(_translate("gameWindow", ""))

        self.noffButton.setText(_translate("gameWindow", "Set Bot as Player 1"))

    def onButtonClicked(self,x,y):
        self.noffButton.setEnabled(False)
        self.noffButton.setText("Thinking...")
        self.listener(x,y)
        if not self.isVictory:
            self.noffButton.setText("Ready")

    def setState(self,x,y,Newstate):
        if Newstate == "":
            self.state[x][y] = 0
            self.pushButton[x][y].setText("")
            self.pushButton[x][y].setEnabled(True)
        elif Newstate == "X":
            self.state[x][y] = 1
            self.pushButton[x][y].setText("X")
            self.pushButton[x][y].setEnabled(False)
        elif Newstate == "O":
            self.state[x][y] = 2
            self.pushButton[x][y].setText("O")
            self.pushButton[x][y].setEnabled(False)

    def getState(self,x,y):
        playerlist = ["","X","O"]
        #print(x,y)
        return playerlist[self.state[x][y]]

    def setVictory(self,playerInt):
        for i in range(self.gridNum):
            for j in range(self.gridNum):
                self.pushButton[i][j].setEnabled(False)
        match(playerInt):
            case 0: # Tie
                self.noffButton.setText("Tie")
            case 1: # Player 1
                self.noffButton.setText("Player Wins")
            case 2: # Player 2
                self.noffButton.setText("Bot Wins")
        self.isVictory = True


            
