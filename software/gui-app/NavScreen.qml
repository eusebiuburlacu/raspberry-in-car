import QtQuick 2.7
import QtLocation 5.6
import QtPositioning 5.6

Item {
    id: mapArea
    width: 800
    height: 480
    visible: false

    Plugin {
        id: mapPlugin
        name: "mapboxgl" // "mapboxgl", "esri", ...

        // specify plugin parameters if necessary
        // PluginParameter {
        //     name:
        //     value:
        // }
    }

    Map {
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(59.91, 10.75) // Oslo
        zoomLevel: 14
        activeMapType: supportedMapTypes[11]
    }
}
