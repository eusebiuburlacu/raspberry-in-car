import QtQuick.Window 2.2
import Qt.labs.calendar 1.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Imagine 2.3
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Dialogs.qml 1.0
import "screens"

Window {
    id: window
    visible: true
    width: 800
    height: 480
    title: qsTr("Home")

    NavScreen
    {
        id: navScreen
    }

    AudioScreen
    {
        id: audioScreen
    }

    VideoScreen
    {
        id: videoScreen
    }

    SettingsScreen
    {
        id: settingsScreen
    }

    HomeScreen
    {
        id: homeScreen
    }

    StackView {
        id: stackView
        x: 0
        y: 0
        width: 800
        height: 480
    }
}
