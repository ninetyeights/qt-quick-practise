import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

AbstractButton {
    id: btnTopBar

    property url btnIconSource: "../../images/svg_images/minimize_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272e"
    property color btnColorClicked: "#00a1f1"

    QtObject {
        id: internal

        property var dynamicColor: if(btnTopBar.down) {
                                       btnTopBar.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnTopBar.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor
        implicitWidth: 35
        implicitHeight: 35

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 16
            width: 16
            fillMode: Image.PreserveAspectFit
            visible: false
            antialiasing: false
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#ffffff"
            antialiasing: false
        }
    }
}
