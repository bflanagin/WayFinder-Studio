import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.1
import "Main.js" as Scripts

import QtQuick.LocalStorage 2.0 as Sql

Item {
    id:window_container


    states: [

        State {
            name:"Show"

            PropertyChanges {
                target:window_container
                y:-(height * 0.05)
            }

        },
        State {
            name:"Hide"

            PropertyChanges {
                target:window_container
                y:-(height * 0.85)

            }
        }


    ]

    transitions: [
        Transition {
            from: "Hide"
            to: "Show"
            NumberAnimation {
                target: window_container
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        },

        Transition {
            from: "Show"
            to: "Hide"
            NumberAnimation {
                target: window_container
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

    ]

    onStateChanged: if(window_container.state == "Show")  {Scripts.listmaps(storyid)}

    Rectangle {
        id:window
        z:0
        width:parent.width * 0.99
        anchors.centerIn: parent
        height:parent.height * 0.95
        radius:8
        color:UbuntuColors.coolGrey
        border.color:UbuntuColors.warmGrey


        Rectangle {
            anchors.fill:options
            radius:8
            anchors.margins: -10
            color:UbuntuColors.warmGrey
            border.color:UbuntuColors.darkAubergine
        }

        GridView {
            id:listgrid
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:label.top
            anchors.top:parent.top
            anchors.topMargin:parent.height * 0.05
            width:parent.width * 0.98
            cellWidth:parent.width
            cellHeight:parent.height * 0.20
            clip:true

            model: ListModel {
                id:maplist


            }

            delegate:  Item {
                        width:listgrid.cellWidth* 0.98
                        height:listgrid.cellHeight * 0.98


                        Rectangle {
                            id:backing
                            color:UbuntuColors.coolGrey
                            anchors.fill:parent
                        }

                        Text {

                            width:parent.width
                            height:parent.height
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            text:name
                            color:"white"
                            font.pixelSize: parent.height * 0.5
                        }


                        MouseArea {
                            width:parent.width
                            height:parent.height
                            hoverEnabled: true
                            onEntered: backing.color = "gray";
                            onExited: backing.color = UbuntuColors.coolGrey;
                            onClicked: if(name == "New Map") {autosave.running = false,Scripts.clearmap()} else {Scripts.load_map(themap),mapid = themap,storyid = thestory}
                        }

            }


        }

        Text {
            id:label
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 8
            text:i18n.tr("Maps")
            color:"white"

            MouseArea {
                width:window_container.width
                height:parent.height
                onClicked: if(window_container.state == "Show")  {window_container.state = "Hide",maplist.clear()} else {window_container.state = "Show"}
            }
        }
    }


}
