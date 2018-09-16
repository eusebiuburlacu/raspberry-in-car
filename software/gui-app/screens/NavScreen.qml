import QtQuick 2.7
import QtLocation 5.9
import QtPositioning 5.6
import QtQuick.VirtualKeyboard 2.0
import QtQuick.Controls 2.3

import "../controls"

Item {
    id: mapArea
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
                text: qsTr("Search address")
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
                    if(textInput.text != "Search address")
                    {
                        geocodeModel.query = textInput.text
                        geocodeModel.update()
                    }
                }

            }

        }
    }

    Plugin {
        id: mapPlugin
        name: "mapboxgl" // "mapboxgl", "esri", ...

        PluginParameter {
            name: "mapboxgl.mapping.use_fbo"
            value: true
        }

        PluginParameter {
            name: "mapboxgl.mapping.items.insert_before"
            value: "aerialway"
        }
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(47.134592, 27.570078) // Iasi
        zoomLevel: 14
        activeMapType: supportedMapTypes[11]

        function updateRoute() {
            routeQuery.clearWaypoints();
            if(geocodeModel.count > 0)
            {
                routeQuery.addWaypoint(QtPositioning.coordinate(47.134592, 27.570078));
                routeQuery.addWaypoint(geocodeModel.get(0).coordinate) //(QtPositioning.coordinate(46.998607, 25.923679));
                map.center = geocodeModel.get(0).coordinate
                map.zoomLevel = 14
            }
        }

        MapItemView {
            model: routeModel

            delegate: MapRoute {
                route: routeData
                line.color: "blue"
                line.width: 4
                opacity: (index == 0) ? 1.0 : 0.3
            }
        }

/*        MapParameter {
            type: "layer"

            property string name: "3d-buildings"
            property string source: "composite"
            property string sourceLayer: "building"
            property string layerType: "fill-extrusion"
            property real minzoom: 15.0
        }

        MapParameter {
            type: "filter"

            property string layer: "3d-buildings"
            property var filter: [ "==", "extrude", "true" ]
        }

        MapParameter {
            type: "paint"

            property string layer: "3d-buildings"
            property string fillExtrusionColor: "#bababa"
            property real fillExtrusionOpacity: 0.6
            property var fillExtrusionHeight: { return { type: "identity", property: "height" } }
            property var fillExtrusionBase: { return { type: "identity", property: "min_height" } }
        }
*/
    }

    RouteModel {
        id: routeModel

        autoUpdate: true
        query: routeQuery

        plugin: Plugin {
            name: "mapbox"

            // Development access token, do not use in production.
            PluginParameter {
                name: "mapbox.access_token"
                value: "pk.eyJ1IjoicXRzZGsiLCJhIjoiY2l5azV5MHh5MDAwdTMybzBybjUzZnhxYSJ9.9rfbeqPjX2BusLRDXHCOBA"
            }
        }

        Component.onCompleted: {
            if (map) {
                map.updateRoute();
            }
        }
    }

    RouteQuery {
        id: routeQuery
    }

    GeocodeModel {
        id: geocodeModel
        plugin:  Plugin {
            name: "mapbox"

            // Development access token, do not use in production.
            PluginParameter {
                name: "mapbox.access_token"
                value: "pk.eyJ1IjoicXRzZGsiLCJhIjoiY2l5azV5MHh5MDAwdTMybzBybjUzZnhxYSJ9.9rfbeqPjX2BusLRDXHCOBA"
            }
        }

        onStatusChanged: {
            map.updateRoute()
        }
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
}
