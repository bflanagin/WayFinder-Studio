import QtQuick 2.4
import Ubuntu.Components 1.3

Item {

    property string title: ""
    property int tab: 0

    states: [

        State {
            name:"pos1"

            PropertyChanges {
                target:window
                color:if (selectedtab == 1) {UbuntuColors.coolGrey} else {UbuntuColors.lightGrey}
            }
            PropertyChanges {
                target:tag
                x:window.x
                color:if (selectedtab == 1) {UbuntuColors.coolGrey} else {UbuntuColors.lightGrey}
            }

        },
        State {
            name:"pos2"

            PropertyChanges {
                target:window
                color:if (selectedtab == 2) {UbuntuColors.coolGrey} else {UbuntuColors.lightGrey}
            }
            PropertyChanges {
                target:tag
                x:window.x + 150
                color:if (selectedtab == 2) {UbuntuColors.coolGrey} else {UbuntuColors.lightGrey}
            }

        },
        State {
            name:"pos3"

            PropertyChanges {
                target:window
                color:if (selectedtab == 3) {UbuntuColors.coolGrey} else {UbuntuColors.lightGrey}
            }
            PropertyChanges {
                target:tag
                x:window.x + 300
                color:if (selectedtab == 3) {UbuntuColors.coolGrey} else {UbuntuColors.lightGrey}
            }
        },
        State {
            name:"hidden"
            PropertyChanges {
                target:window_container
                visible:false
            }
        }

    ]

    Item {
        width:parent.width
        height:parent.height
        id:window_container

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
            text:title
            color:UbuntuColors.orange
        }

        MouseArea {
            anchors.fill:parent
            onClicked:selectedtab = tab;
        }

    }


}


}
