import QtQuick 2.7
import QtQuick.VirtualKeyboard 2.0
import Qt.labs.folderlistmodel 2.2
import QtMultimedia 5.8

import "../controls"
import QtQuick.Controls 2.3

Item {
    id: audioScreen
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

            TextInput {
                id: textInput
                text: qsTr("Search music")
                color: "grey"
                font.pixelSize: 16
                padding: 5

                onFocusChanged: {
                    if(textInput.focus == true) {
                        textInput.text = ""
                    }
                    else {
                        textInput.text = "Search address"
                    }
                }

                onEditingFinished: {
                    textInput.focus = false
                }

            }

        }
    }

    Rectangle {
        anchors.fill: parent
        id: rectangleMusic
        color: "#4b4b4b"
        border.width: 0
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    MediaPlayer {
        id: playMusic
        //source: currently selected file in TreeView
    }

    FolderListModel {
        id: musicFolder
        folder: "file://home/pi/Music"
        showDirs: false
        nameFilters: ["*.mp3"]
    }

    ListView {
        id: musicListView
        x: 542
        y: 30
        width: 258
        height: 480
        model: musicFolder

        onCurrentIndexChanged: {
            // This will handle changing playlist with all possible selection methods
            playMusic.source = musicFolder.get(currentIndex, "fileURL")
            playMusic.play();
        }

        delegate: Component {
            Item {
                width: parent.width
                height: 40
                Column {
                    Text { text: fileName }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        musicListView.currentIndex = index
                    }
                }
            }
        }
        highlight: Rectangle {
            color: 'grey'
        }
        focus: true
    }

    Button {
        id: previous
        x: 71
        y: 258
        text: qsTr("Previous")

        onClicked: {

        }
    }

    Button {
        id: next
        x: 257
        y: 258
        text: qsTr("Next")

        onClicked: {

        }
    }

}
