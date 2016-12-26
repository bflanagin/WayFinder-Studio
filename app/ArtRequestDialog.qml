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
    property string dbsource: "none"
    property string search: " "

    MouseArea {
        anchors.fill:parent
    }

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
    width:parent.width
    height:parent.height
    color:UbuntuColors.coolGrey
    border.color:"grey"
    border.width:10

}

Column {
    anchors.centerIn:parent
    width:parent.width * 0.90
    height:parent.height* 0.90

    spacing:5

    Rectangle {
        id:upload
        width:parent.width
        height:parent.height * 0.48
        color:UbuntuColors.coolGrey

        Text {
            anchors.centerIn: parent
            font.pixelSize: (parent.height - text.length) * 0.2
            text:i18n.tr("Upload your own")
            color:"white"
        }

        MouseArea {
            anchors.fill:parent
            hoverEnabled: true
            onEntered: upload.color = UbuntuColors.darkGrey
            onExited: upload.color = UbuntuColors.coolGrey
            onClicked: window_container.state = "Hide",console.log("working on it")

        }

    }
    Rectangle {
        id:request
        width:parent.width
        height:parent.height * 0.48
        color:UbuntuColors.coolGrey

        Text {
            anchors.centerIn: parent
            font.pixelSize: (parent.height - text.length) * 0.2
            text:i18n.tr("Request")
            color:"white"
        }

        MouseArea {
            anchors.fill:parent
            hoverEnabled: true
            onEntered: request.color = UbuntuColors.darkGrey
            onExited: request.color = UbuntuColors.coolGrey
            onClicked: window_container.state = "Hide",artistfinder.state = "Show"
        }
    }
}


}
