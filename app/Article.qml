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
        border.color:"gray"





    }

    Rectangle {
        id:tag

        width:tagtext.width * 1.30
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


    }




}
