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



                    Text {
                     text:name
                     anchors.top:parent.bottom
                     anchors.horizontalCenter: parent.horizontalCenter
                     anchors.topMargin:10
                     color:"white"
                    }

                    }
                }


        model: ListModel {
                id: currentlist

                ListElement {
                    name:"test artist"
                }



        }

    }




}
