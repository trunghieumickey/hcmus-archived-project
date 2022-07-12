from PyQt6 import QtCore, QtWidgets
from ALG_PathFinder import bresenham

class UI_PathFinder(object):
    def __init__(self):
        self.validState = ["Start","Goal","Path","Expanded","Obstacle","Waypoint"]

    def setupUi(self, MainWindow, width, height, baseSize = 15):
        width += 1
        height += 1
        MainWindow.setObjectName("Path Finder")
        MainWindow.resize(baseSize*width, baseSize*height)
        MainWindow.setMinimumSize(QtCore.QSize(baseSize*width, baseSize*height))
        MainWindow.setMaximumSize(QtCore.QSize(baseSize*width, baseSize*height))
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.label = [[] for i in range(height)]
        self.state = [[2]*width for i in range(height)]
        for i in range(height):
            for j in range(width):
                self.label[i].append(QtWidgets.QLabel(self.centralwidget))
                self.label[i][j].setGeometry(QtCore.QRect(baseSize*j, baseSize*i, baseSize, baseSize))
                self.label[i][j].setAutoFillBackground(False)
                self.label[i][j].setStyleSheet("QLabel {background-color:rgb(255, 255, 255);}")
                self.label[i][j].setText("")
                self.label[i][j].setTextFormat(QtCore.Qt.TextFormat.AutoText)
                self.label[i][j].setObjectName("label")
        for i in range(height):
            self.label[i][0].setStyleSheet("QLabel {background-color:rgb(0, 0, 0);}")
            self.label[i][width-1].setStyleSheet("QLabel {background-color:rgb(0, 0, 0);}")
            self.state[i][0] = 4
            self.state[i][width-1] = 4
        for i in range(width):
            self.label[0][i].setStyleSheet("QLabel {background-color:rgb(0, 0, 0);}")
            self.label[height-1][i].setStyleSheet("QLabel {background-color:rgb(0, 0, 0);}")
            self.state[0][i] = 4
            self.state[height-1][i] = 4
        MainWindow.setCentralWidget(self.centralwidget)
        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))

    def setStatePoint(self,x,y,state):
        if state in self.validState :
            self.state[y][x] = self.validState.index(state)
            invertY = len(self.state)-1-y
            match(self.state[y][x]):
                case 0:
                    self.label[invertY][x].setStyleSheet("QLabel {background-color:rgb(255, 0, 0);}")
                case 1:
                    self.label[invertY][x].setStyleSheet("QLabel {background-color:rgb(255, 0, 0);}")
                case 2:
                    self.label[invertY][x].setStyleSheet("QLabel {background-color:rgb(255, 255, 255);}")
                case 3:
                    self.label[invertY][x].setStyleSheet("QLabel {background-color:rgb(255, 153, 0);}")
                case 4:
                    self.label[invertY][x].setStyleSheet("QLabel {background-color:rgb(0, 0, 0);}")
                case 5:
                    self.label[invertY][x].setStyleSheet("QLabel {background-color:rgb(0, 255, 0);}")
        else:
            print("Invalid state")

    def setStateLine(self,x1,y1,x2,y2,state):
        point = bresenham(x1,y1,x2,y2)
        for i in point:
            self.setStatePoint(*i,state)
    
    def setStatePoligon(self,points:list,state):
        if len(points)%2 != 0:
            return
        for i in range(0,len(points)-2,2):
            self.setStateLine(points[i],points[i+1],points[i+2],points[i+3],state)
        self.setStateLine(points[len(points)-2],points[len(points)-1],points[0],points[1],state)

    def getState(self,x,y):
        return self.validState[self.state[y][x]]
