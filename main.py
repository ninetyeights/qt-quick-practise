# This Python file uses the following encoding: utf-8
import sys
import os
import datetime
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal, QTimer, QUrl

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

        self.timer = QTimer()
        self.timer.timeout.connect(lambda: self.setTime())
        self.timer.start(1000)

    # signal set name
    setName = Signal(str)

    # signal set data
    printTime = Signal(str)

    # signal visible
    isVisible = Signal(bool)

    # Open File To Text Edit
    readText = Signal(str)

    # Text String
    textField = ""

    # Open File
    @Slot(str)
    def openFile(self, filePath):
        print("Hello" + filePath)
        file = open(QUrl(filePath).toLocalFile(), encoding="utf-8")
        text = file.read()
        file.close()
        print(text)
        self.readText.emit(str(text))

    # Read Text
    @Slot(str)
    def getTextField(self, text):
        self.textField = text

    # Write File
    @Slot(str)
    def writeFile(self, filePath):
        file = open(QUrl(filePath).toLocalFile(), "w")
        file.write(self.textField)
        file.close()
        print(self.textField)

    @Slot(bool)
    def showHideRectangle(self, isChecked):
        print(isChecked)
        self.isVisible.emit(isChecked)

    def setTime(self):
        now = datetime.datetime.now()
        formatDate = now.strftime("Now is %H:%M:%S %p of %Y/%m/%d")
        self.printTime.emit(formatDate)

    @Slot(str)
    def welcomeText(self, name):
        self.setName.emit("Welcome, " + name)


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Get Context
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)

    qml_file = Path(__file__).resolve().parent / "qml/main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
