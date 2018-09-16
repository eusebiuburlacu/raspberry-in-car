import QtQuick 2.7
import QtQuick.Controls 2.3

Item {
    id: homeArea
    width: 800
    height: 480
    visible: true

    Frame {
        id: frame
        x: 195
        y: 362
        width: 410
        height: 50
        padding: 0

        Rectangle {
            anchors.fill: parent
            id: rectangle
            color: "#4b4b4b"
            border.width: 0

            Row {
                id: row
                x: 0
                y: 0
                width: 409
                height: 50
                layoutDirection: Qt.LeftToRight
                spacing: 2


                Button {
                    id: button
                    height: 50
                    text: qsTr("Navigation")
                    onClicked: {
                        stackView.push(navScreen)
                    }
                }

                Button {
                    id: button1
                    height: 50
                    text: qsTr("Audio")
                    onClicked: {
                        stackView.push(audioScreen)
                    }
                }

                Button {
                    z: 1
                    id: button2
                    height: 50
                    text: qsTr("Video")
                    onClicked: {
                        stackView.push(videoScreen)
                    }
                }

                Button {
                    id: button4
                    height: 50
                    text: qsTr("Settings")
                    onClicked: {
                        stackView.push(settingsScreen)
                    }
                }
            }

        }

    }

}
