import QtQuick 2.7
import Qt.labs.calendar 1.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Imagine 2.3
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import QtGraphicalEffects 1.0

Button {
    id: button7
    width: 60
    text: qsTr("<--")

    background: Rectangle {
        anchors.fill: parent
        color: "black"
    }

    onClicked: {
        stackView.clear()
    }
}
