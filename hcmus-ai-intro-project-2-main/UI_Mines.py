from PyQt6 import QtCore, QtWidgets
from RND_Mines import onRandomClick
from time import perf_counter
from ALG_Mines import *

class UI_Mines(object):
    def setupUi(self, MainWindow, width = 0, height = 0, baseSize = 20):
        self.width = width
        self.height = height
        minWidth = max(width*baseSize, 10*baseSize)
        minHeight = (3+height)*baseSize
        MainWindow.setObjectName("Mines")
        MainWindow.resize(minWidth, minHeight)
        MainWindow.setMinimumSize(QtCore.QSize(minWidth, minHeight))
        MainWindow.setMaximumSize(QtCore.QSize(minWidth, minHeight))
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.label = [[] for i in range(height)]
        self.state = [[False]*width for i in range(height)]
        self.number = [[-1]*width for i in range(height)]
        for i in range(height):
            for j in range(width):
                self.label[i].append(QtWidgets.QLabel(self.centralwidget))
                self.label[i][j].setGeometry(QtCore.QRect(baseSize*j, baseSize*(i+3), baseSize, baseSize))
                self.label[i][j].setAutoFillBackground(False)
                self.label[i][j].setStyleSheet("QLabel {background-color:rgb(255, 0, 0);color:rgb(255, 255, 255);}")
                self.label[i][j].setText("")
                self.label[i][j].setTextFormat(QtCore.Qt.TextFormat.AutoText)
                self.label[i][j].setObjectName("label")
        self.heightSpinBox = QtWidgets.QSpinBox(self.centralwidget)
        self.heightSpinBox.setGeometry(QtCore.QRect(baseSize*6, baseSize, baseSize*2, baseSize))
        self.heightSpinBox.setMinimum(3)
        self.heightSpinBox.setMaximum(20)
        self.widthSpinBox = QtWidgets.QSpinBox(self.centralwidget)
        self.widthSpinBox.setGeometry(QtCore.QRect(baseSize*8, baseSize, baseSize*2, baseSize))
        self.widthSpinBox.setMinimum(3)
        self.widthSpinBox.setMaximum(20)
        self.browseButton = QtWidgets.QPushButton(self.centralwidget)
        self.browseButton.setGeometry(QtCore.QRect(0, 0, baseSize*10, baseSize))
        self.browseButton.setObjectName("pushButton")
        self.browseButton.clicked.connect(lambda: self.onButtonClicked(1,MainWindow))
        self.randomButton = QtWidgets.QPushButton(self.centralwidget)
        self.randomButton.setGeometry(QtCore.QRect(0, baseSize, baseSize*6, baseSize))
        self.randomButton.setObjectName("pushButton")
        self.randomButton.clicked.connect(lambda: self.onButtonClicked(2,MainWindow))
        self.runButton = QtWidgets.QPushButton(self.centralwidget)
        self.runButton.setGeometry(QtCore.QRect(baseSize*5, baseSize*2, baseSize*5, baseSize))
        self.runButton.setObjectName("pushButton")
        self.runButton.clicked.connect(lambda: self.onRunClick(MainWindow))
        self.dropdown = QtWidgets.QComboBox(self.centralwidget)
        self.dropdown.setGeometry(QtCore.QRect(0, baseSize*2, baseSize*5, baseSize))
        self.dropdown.setObjectName("dropdown")
        self.dropdown.addItem("CNF")
        self.dropdown.addItem("Bruteforce")
        self.dropdown.addItem("Back-tracking")
        self.dropdown.addItem("Astar")
        MainWindow.setCentralWidget(self.centralwidget)
        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.browseButton.setText(_translate("MainWindow", "Browse"))
        self.randomButton.setText(_translate("MainWindow", "Randomize"))
        self.runButton.setText(_translate("MainWindow", "Run"))

    def setState(self,x,y,state):
        if state:
            self.label[x][y].setStyleSheet("QLabel {background-color:rgb(0, 255, 0);}")
        else:
            self.label[x][y].setStyleSheet("QLabel {background-color:rgb(255, 0, 0);color:rgb(255, 255, 255);}")
        self.state[x][y] = state

    def setNumber(self,x,y,number):
        self.number[x][y] = number
        if number != -1:
            self.label[x][y].setText(" "+str(number))

    def getState(self,x,y):
        return self.state[x][y]

    def getNumber(self,x,y):
        return self.number[x][y]

    def onButtonClicked(self, method, MainWindow):
        try:
            match(method):
                case 1:
                    filename = self.onBrowseClick()
                case 2:
                    filename = onRandomClick(self.heightSpinBox.value(), self.widthSpinBox.value())
            with open(filename, 'r') as f:
                width = len(f.readline().split())
                height = len(f.readlines()) + 1
                f.seek(0)
                width, height = int(width), int(height)
                self.setupUi(MainWindow, width, height)
                for i in range(self.height):
                    temp = f.readline().split()
                    for j in range(self.width):
                        self.setNumber(i,j,int(temp[j]))
        except:
            pass
        

    def onBrowseClick(self):
        filename = QtWidgets.QFileDialog.getOpenFileName(None, 'Open File', '.', 'Text Files (*.txt)')
        return filename[0]

    def onRunClick(self,MainWindow):
        #get dropdown index
        start = perf_counter()
        match(self.dropdown.currentIndex()):
            case 0:
                Cnf_pysat(self)
            case 1:
                brute_force(self)
            case 2:
                backtracking(self)
            case 3:
                pass
        print(perf_counter() - start)

        


