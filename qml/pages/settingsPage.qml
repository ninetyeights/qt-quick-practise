import QtQuick 2.15
import QtQuick.Controls

Item {
    Rectangle {
        id: rectangle
        color: "#2c313c"
        anchors.fill: parent

        Label {
            id: label
            color: "#ffffff"
            text: qsTr("Settings Page")
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}
