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

    onStateChanged: if(window_container.state == "Show"){console.log(thingid,type),Scripts.codex_article(type,thingid)}

    MouseArea {
        anchors.fill:parent
    }

    Rectangle {
        id:window

        width:parent.width * 0.99
        anchors.centerIn: parent
        height:parent.height * 0.95
        radius:8
        color:UbuntuColors.coolGrey
        border.color:"gray"





    }

    Rectangle {
        id:tag

        width:(tagtext.width + closebutton.width) * 1.30
        height:parent.height * 0.05
        x:window.x
        y:window.y * -0.02
        radius:8
         border.color:"gray"
        color:UbuntuColors.coolGrey

        Text {
            id:tagtext
            anchors.left: parent.left
            anchors.leftMargin:10
            anchors.top:parent.top
            anchors.topMargin:5
            text:name
            color:UbuntuColors.orange
        }

        Rectangle {
            width:parent.width * 1.1
            height:parent.height * 0.5
            color:UbuntuColors.coolGrey
            y:parent.height * 0.60
            x:1.5
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

    Item {
        anchors.top:tag.bottom
        anchors.left:window.left
        anchors.leftMargin:parent.width * 0.01
        height:window.height * 0.9
        width:window.width * 0.50


        Rectangle {
            radius:8
            anchors.centerIn: parent
            width:parent.width * 1.02
            height:parent.height * 1.02
            color:"white"

        }

        Flickable {
            width:parent.width
            height:parent.height
            contentHeight: the_d.height+ the_d.y
             clip:true


        Text {
                id:the_d
            width:parent.width
            height:parent.height
            wrapMode:Text.WordWrap
            text:item_discription

        }

        }

    }

    Item {
        anchors.top:tag.bottom
        anchors.right:window.right
        anchors.rightMargin:parent.width * 0.01
        height:window.height * 0.9
        width:window.width * 0.45



        Image {
                id:the_ii
            width:parent.width
            height:parent.height * 0.80
            source:"graphics/newImageAdd.png"


            MouseArea {
                anchors.fill:parent
                onClicked:imageopts.state = "Show"
            }

        }

        Rectangle {
            radius:8
            anchors.top:the_ii.bottom
            anchors.topMargin:parent.height * 0.01
            height:parent.height - the_ii.height
            width:parent.width
            color:UbuntuColors.coolGrey
            border.color:"grey"
            clip:true


            Text {
                anchors.left:parent.left
                anchors.top:parent.top
                anchors.margins: parent.width * 0.01
                height:parent.height * 0.99
                width: parent.width * 0.99
                text:item_stats
                wrapMode:Text.WordWrap
                color:"white"
                font.pixelSize: height / 7
            }


        }


    }

    ArtRequestDialog {
        id:imageopts
        anchors.centerIn: parent
        width:parent.width * 0.80
        height:parent.height * 0.50
        state:"Hide"
    }


}
