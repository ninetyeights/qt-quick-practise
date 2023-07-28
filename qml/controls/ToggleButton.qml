import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

AbstractButton {
    id: btnToggle

    property url btnIconSource: "../../images/svg_images/menu_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272e"
    property color btnColorClicked: "#00a1f1"

    QtObject {
        id: internal

        property var dynamicColor: if(btnToggle.down) {
                                       btnToggle.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnToggle.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor
        implicitWidth: 70
        implicitHeight: 60

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
            visible: false
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#ffffff"
            antialiasing: false
        }
    }
}
