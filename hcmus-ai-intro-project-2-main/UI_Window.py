from PyQt6 import QtWidgets
import sys

class gameWindow():
    def __init__(self,ui,*params):
        self.app = QtWidgets.QApplication(sys.argv)
        self.window = QtWidgets.QMainWindow()
        self.ui = ui()
        self.ui.setupUi(self.window, *params)
        self.window.show()

    def reset(self,*params):
        self.ui.setupUi(self.window, *params)

    def execute(self):
        self.app.exec()