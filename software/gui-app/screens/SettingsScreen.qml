import QtQuick 2.7
import "../controls"

Item {
    id: settingsScreen
    width: 800
    height: 480
    visible: false

    Rectangle {
        id: navTopBar
        x: 0
        y: 0
        z: 1
        width: 800
        height: 30
        opacity: 0.8
        color: "black"

        Row
        {
            id: searchRow
            anchors.fill: parent

            HomeButton {
                id: button8
                height: navTopBar.height
            }

            Rectangle{
                height: parent.height
                width: 1
                color: "grey"
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        id: rectangleSettings
        color: "#4b4b00"
        border.width: 0
    }
}
