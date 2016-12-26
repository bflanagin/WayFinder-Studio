import QtQuick 2.4
import Ubuntu.Components 1.3
import WayFinder 1.0

import QtQuick.LocalStorage 2.0 as Sql

import QtQuick.Controls 1.4

import "Main.js" as Scripts
import "openseed.js" as OpenSeed


Item {
    width:parent.width
    height:parent.height
    id:window_container

    property string thingid: ""
    property string type:""
    property string name:""
    property string item_discription:""
    property string item_stats:""



    states: [

        State {
            name:"Show"

            PropertyChanges {
                target:window_container
                visible:true
            }

        },
        State {
            name:"Hide"

            PropertyChanges {
                target:window_container
                visible:false

            }
        }


    ]


    Rectangle {
        id:window

        width:parent.width * 0.99
        anchors.centerIn: parent
        height:parent.height * 0.95
        radius:8
        color:UbuntuColors.coolGrey





    }

    Rectangle {
        id:tag

        width:window.width * 0.10
        height:parent.height * 0.05
        x:window.x
        y:window.y * -0.02
        radius:8
        color:UbuntuColors.coolGrey

        Text {
            id:tagtext
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:parent.top
            anchors.topMargin:5
            text:i18n.tr("Artists")
            color:UbuntuColors.orange
        }

        Rectangle {
            id:closebutton
            anchors.right:parent.right
            anchors.top:parent.top
            anchors.margins:parent.width * 0.03
            width:parent.height * 0.5
            height:parent.height * 0.5
            radius:width /2
            color:UbuntuColors.coolGrey
            //border.color:"white"

            Image {
                anchors.centerIn: parent
                width:parent.width * 0.80
                height:parent.width * 0.80
                fillMode:Image.PreserveAspectFit
                source:"/usr/share/icons/suru/actions/scalable/close.svg"
            }

            MouseArea {
                anchors.fill:parent
                hoverEnabled: true
                onEntered: closebutton.color = UbuntuColors.darkGrey
                    onExited:closebutton.color = UbuntuColors.coolGrey
                    onClicked:window_container.state ="Hide"
            }
        }


    }


    TextField {
        anchors.top:window.top
        anchors.right:window.right
        anchors.margins:10

        width: parent.width * 0.30

        Text {
            anchors.right:parent.left

            anchors.verticalCenter: parent.verticalCenter
        text: i18n.tr("Search: ")
        color:"white"
        font.pixelSize: parent.height
        }


    }

    GridView{
        id:currentgrid
        anchors.top:tag.bottom
        anchors.topMargin:40
        width:window.width * 0.85
        height:window.height * 0.70
        cellHeight: window.height * 0.60
        cellWidth: window.width * 0.30
        flow: GridView.FlowTopToBottom
        clip:true

        delegate:
            Item {
                width:currentgrid.cellWidth * 0.96
                height:currentgrid.cellHeight * 0.98
                clip:true
                Image {
                    //anchors.centerIn:parent
                    source:"graphics/newImageAdd.png"
                    //anchors.fill:parent
                    width:parent.width
                    height:parent.height * 0.90
                    fillMode:Image.PreserveAspectFit

                    Image {
                        source:"graphics/newImageAdd.png"
                        anchors.bottom:parent.bottom
                        anchors.right:parent.right
                        anchors.rightMargin:parent.width * 0.01
                        width:parent.width * 0.3
                        height:parent.width * 0.3
                        fillMode:Image.PreserveAspectFit

                    }

                    Text {
                     text:name
                     anchors.top:parent.bottom
                     anchors.horizontalCenter: parent.horizontalCenter
                     anchors.topMargin:10
                     color:"white"
                    }

                    }

                    MouseArea {
                        anchors.fill:parent
                        onClicked: preview.state = "Show"
                    }
                }


        model: ListModel {
                id: currentlist

                ListElement {
                    name:"test artist"
                }



        }

    }

    Item {
        id:preview
        anchors.centerIn: parent
        width:parent.width * 0.40
        height:parent.height * 0.90

        states: [

            State {
                name:"Show"

                PropertyChanges {
                    target:preview
                    opacity:1
                }

            },
            State {
                name:"Hide"

                PropertyChanges {
                    target:preview
                    opacity:0
                }
            }


        ]

        state: "Hide"



        Rectangle {
            id:preview_window
            width:parent.width * 0.98
            height:parent.height * 0.98
            color:UbuntuColors.coolGrey
            border.color: "grey"
            border.width: 4

            Column {
                id:info_view
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.96
                height:parent.height * 0.98
                spacing:4


                states: [

                    State {
                        name:"Show"

                        PropertyChanges {
                            target:info_view
                            opacity:1
                        }

                    },
                    State {
                        name:"Hide"

                        PropertyChanges {
                            target:info_view
                            opacity:0
                        }
                    }


                ]

                transitions: [
                   Transition {
                       from: "Hide"
                       to: "Show"

                       NumberAnimation {
                           target: info_view
                           property: "opacity"
                           duration: 200
                           easing.type: Easing.InOutQuad
                       }

                   },

                   Transition {
                       from: "Show"
                       to: "Hide"

                       NumberAnimation {
                           target: info_view
                           property: "opacity"
                           duration: 200
                           easing.type: Easing.InOutQuad
                       }

                   }


               ]

               state:"Hide"




            Text {
                //anchors.top:parent.top
                //anchors.left:parent.left
                text:"Test Artist"
                color:"white"
                font.pixelSize: preview_window.height * 0.05

            }
            Rectangle {
                width:parent.width
                height:parent.height * 0.01
                color:"gray"
            }

            Text {

                text:"Discription:"
                color:"white"
                font.pixelSize: preview_window.height * 0.04

            }
            Text {

                text:"Testing a long bit of text that will serve as the artist bio"
                color:"white"
                font.pixelSize: preview_window.height * 0.02
                width:parent.width
                wrapMode:Text.WordWrap

            }


            }

        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:preview_window.bottom
            anchors.bottomMargin: 10
            text:i18n.tr("Click to Request")
            font.pixelSize: parent.width * 0.04
            color:"white"
        }

        Rectangle {
            id:avatar
            anchors.right:parent.right
            anchors.bottom:parent.bottom
            width:parent.width * 0.2
            height:parent.width * 0.2
            color:UbuntuColors.coolGrey
            border.color: "grey"
            border.width: 4
        }


        MouseArea {
            anchors.fill:parent
            hoverEnabled: true
            onEntered: info_view.state = "Show"
            onExited: info_view.state = "Hide"
            onClicked: preview.state = "Hide"
        }

    }




}
