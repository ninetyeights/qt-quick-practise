import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects
import "controls"


Window {
    id: mainWindow
    width: 980
    height: 560
    minimumWidth: 800
    minimumHeight: 500
    visible: true
    color: "transparent"
    title: qsTr("Qt Quick Practise")

    flags: Qt.Window | Qt.FramelessWindowHint

    property int windowStatus: 0
    property int windowMargin: 10

    // Text Edit Properties
    property alias actualPage: stackView.currentItem

    QtObject {
        id: internal

        function maximizeRestore() {
            if(windowStatus == 0) {
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
                resizeLeft.visible = resizeRight.visible = resizeTop.visible = resizeBottom.visible = false
                btnMaximizeRestore.btnIconSource = "../../images/svg_images/restore_icon.svg"
            } else {
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                resizeLeft.visible = resizeRight.visible = resizeTop.visible = resizeBottom.visible = true
                btnMaximizeRestore.btnIconSource = "../../images/svg_images/maximize_icon.svg"
            }
        }

        function ifMaximizedWindowRestore() {
            if (windowStatus == 1) {
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                resizeLeft.visible = resizeRight.visible = resizeTop.visible = resizeBottom.visible = true
                btnMaximizeRestore.btnIconSource = "../../images/svg_images/maximize_icon.svg"
            }
        }

        function restoreMargins() {
            windowStatus = 0
            windowMargin = 10
            resizeLeft.visible = resizeRight.visible = resizeTop.visible = resizeBottom.visible = true
            btnMaximizeRestore.btnIconSource = "../../images/svg_images/maximize_icon.svg"
        }
    }

    Rectangle {
        id: bg
        color: "#2c313b"
        border.color: "#383b4c"
        border.width: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        z: 1

        Rectangle {
            id: appContainer
            color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                height: 60
                color: "#1c1d20"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                ToggleButton {
                    onClicked: animationMenu.running = true
                }

                Rectangle {
                    id: topBarDescription
                    y: 34
                    height: 25
                    color: "#2c313b"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 70
                    anchors.bottomMargin: 0

                    Label {
                        id: labelTopInfo
                        color: "#5f6a82"
                        text: qsTr("Application Description")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 300
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                    }

                    Label {
                        id: labelRightInfo
                        x: -5
                        y: -5
                        color: "#5f6a82"
                        text: qsTr("| Home")
                        anchors.left: labelTopInfo.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        anchors.rightMargin: 10
                        anchors.leftMargin: 0
                    }
                }

                Rectangle {
                    id: titleBar
                    height: 35
                    color: "#00ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 105
                    anchors.leftMargin: 70
                    anchors.topMargin: 0

                    DragHandler {
                        onActiveChanged: if(active) {
                                             mainWindow.startSystemMove()
                                             internal.ifMaximizedWindowRestore()
                                         }
                    }

                    Image {
                        id: iconApp
                        width: 22
                        height: 22
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "../images/svg_images/icon_app_top.svg"
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 5
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: label
                        color: "#c3cbdd"
                        text: qsTr("Qt Quick Practise")
                        anchors.left: iconApp.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 10
                        anchors.leftMargin: 5
                    }
                }

                Row {
                    id: rowBtns
                    width: 105
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.topMargin: 0

                    TopBarButton {
                        id: btnMinimize
                        onClicked: {
                            mainWindow.showMinimized()
                            internal.restoreMargins()
                        }
                    }

                    TopBarButton {
                        id: btnMaximizeRestore
                        btnIconSource: "../../images/svg_images/maximize_icon.svg"
                        onClicked: internal.maximizeRestore()
                    }

                    TopBarButton {
                        id: btnClose
                        btnColorClicked: "#f100d7"
                        btnIconSource: "../../images/svg_images/close_icon.svg"
                        onClicked: mainWindow.close()
                    }
                }
            }

            Rectangle {
                id: content
                color: "#2c313b"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 70
                    color: "#1c1d20"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    PropertyAnimation {
                        id: animationMenu
                        target: leftMenu
                        property: "width"
                        to: if (leftMenu.width == 70) return 200; else return 70
                        duration: 700
                        easing.type: Easing.OutBounce
                    }

                    Column {
                        id: columnMenus
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 90
                        anchors.topMargin: 0

                        LeftMenuBtn {
                            id: btnHome
                            width: leftMenu.width
                            text: qsTr("Home")
                            isActiveMenu: true
                            onClicked: {
                                btnHome.isActiveMenu = true
                                btnSettings.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl("pages/homePage.qml"))
//                                pagesView.setSource(Qt.resolvedUrl("pages/homePage.qml"))
                            }
                        }

                        LeftMenuBtn {
                            id: btnOpen
                            width: leftMenu.width
                            text: qsTr("Open")
                            btnIconSource: "../../images/svg_images/open_icon.svg"

                            onPressed: {
                                                            fileOpen.open()
                                                        }

                                                        FileDialog {
                                                            id: fileOpen
                                                            title: "Please choose a file"
//                                                            folder: shortcuts.home
//                                                            selectMultiple: false
                                                            nameFilters: ["Text File (*.txt)"]
                                                            onAccepted: {
                                                                console.log(fileOpen.selectedFile)
                                                                backend.openFile(fileOpen.selectedFile)
                                                            }
                                                        }
                        }

                        LeftMenuBtn {
                            id: btnSave
                            width: leftMenu.width
                            text: qsTr("Save")
                            btnIconSource: "../../images/svg_images/save_icon.svg"

                            onPressed: {
                                fileSave.open()
                            }

                            FileDialog {
                                id: fileSave
                                title: "Save file"
//                                folder: shortcuts.home
                                fileMode: FileDialog.SaveFile
                                nameFilters: ["Text File (*.txt)"]
//                                selectExisting: false
                                onAccepted: {
                                    backend.getTextField(actualPage.getText)
                                    backend.writeFile(fileSave.selectedFile)
                                }
                            }
                        }
                    }

                    LeftMenuBtn {
                        id: btnSettings
                        x: 0
                        y: 180
                        width: leftMenu.width
                        text: qsTr("Settings")
                        anchors.bottom: parent.bottom
                        btnIconSource: "../../images/svg_images/settings_icon.svg"
                        onClicked: {
                            btnHome.isActiveMenu = false
                            btnSettings.isActiveMenu = true
                            stackView.push(Qt.resolvedUrl("pages/settingsPage.qml"))
//                            pagesView.setSource(Qt.resolvedUrl("pages/settingsPage.qml"))
                        }
                    }
                }

                Rectangle {
                    id: contentPages
                    color: "#00000000"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 25
                    anchors.topMargin: 0

                    StackView {
                        id: stackView
                        anchors.fill: parent
                        initialItem: "pages/textEditor.qml"
                    }

//                    Loader {
//                        id: pagesView
//                        anchors.fill: parent
//                        source: Qt.resolvedUrl("pages/homePage.qml")
//                    }
                }

                Rectangle {
                    id: rectangle
                    color: "#282c34"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPages.bottom
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    Label {
                        id: labelTopInfo1
                        x: -60
                        y: -453
                        color: "#5f6a82"
                        text: qsTr("Application Description")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        anchors.rightMargin: 30
                        anchors.leftMargin: 10
                    }

                    MouseArea {
                        id: resizeWindow
                        x: 913
                        y: 523
                        width: 16
                        height: 16
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        cursorShape: Qt.SizeFDiagCursor

                        DragHandler {
                            target: null
                            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge) }
                        }

                        Image {
                            id: resizeImage
                            x: 0
                            y: 0
                            width: 16
                            height: 16
                            opacity: 0.5
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            source: "../images/svg_images/resize_icon.svg"
                            anchors.bottomMargin: 0
                            anchors.rightMargin: 0
                            sourceSize.height: 16
                            sourceSize.width: 16
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }
                    }
                }
            }
        }
    }

    DropShadow {
        id: dropShadow
        anchors.fill: bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#80000000"
        source: bg
        z: 0
    }

    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.LeftEdge) }
        }
    }

    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.RightEdge) }
        }
    }

    MouseArea {
        id: resizeBottom
        y: 556
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.BottomEdge) }
        }
    }

    MouseArea {
        id: resizeTop
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.TopEdge) }
        }
    }

    Connections{
            target: backend

            function onReadText(text){
                actualPage.setText = text
            }
        }
}
