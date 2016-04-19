import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.1
import "Main.js" as Scripts

Item {
    property string areaname: "No Name"
    property int zoomlevel: 1
    property string discription: ""

    onZChanged: Scripts.mapgrid()


    Rectangle {
        color:UbuntuColors.warmGrey
        anchors.fill:mapflick
        anchors.margins: -10
        radius:8
    }
    Flickable {
            id:mapflick
        width:parent.width * 0.90
        height:parent.height * 0.95
        anchors.left:parent.left
        anchors.leftMargin:20
        anchors.verticalCenter: parent.verticalCenter
        contentHeight: maparea.height * 1.2
        contentWidth:maparea.width
        clip:true

        Item {
            id:maparea
            width:parent.width * zoomlevel
            height:parent.width * zoomlevel
        }

    }

    Text {
        anchors.bottom:parent.bottom
        anchors.margins:10
        anchors.left: parent.left
        id:title
        text:i18n.tr("Map - "+areaname)
        color:"white"
        font.pixelSize: parent.height * 0.03
    }

    Rectangle {
        id:zoomin
        anchors.left:parent.left
        anchors.top:parent.top
        anchors.margins:10
        height:parent.height * 0.04
        width:parent.height * 0.04
        radius:width / 2
        color:UbuntuColors.coolGrey
        border.color:UbuntuColors.lightGrey

        Text {
            anchors.centerIn:parent
            text: "+"
            color:"white"
            font.pixelSize:parent.width / 1.5
        }

        MouseArea {
            anchors.fill:parent
            onClicked:zoomlevel = zoomlevel+1
        }
    }
    Rectangle {
        id:zoomout
        anchors.top:zoomin.bottom
        anchors.topMargin:4
        anchors.left:zoomin.left
        height:parent.height * 0.04
        width:parent.height * 0.04
        radius:width / 2
        color:UbuntuColors.coolGrey
        border.color:UbuntuColors.lightGrey

        Text {
            anchors.centerIn:parent
            text: "-"
            color:"white"
            font.pixelSize:parent.width / 1.5
        }
    }



    Rectangle {
        anchors.right:parent.right
        anchors.top:parent.top
        height:parent.height
        width:parent.width * 0.20
        radius:8
        color:UbuntuColors.coolGrey
        border.color:UbuntuColors.lightGrey

        Column {
            id:roomcolumn
            width:parent.width
            height:parent.height
            spacing:10

            Item {
                width:parent.width
                height:locale.height + locale.y

            Text {
                text:i18n.tr("Location:")
                color:"white"
                x:4
                font.pixelSize: roomcolumn.height * 0.025
                TextField {
                    id:locale
                    anchors.top:parent.bottom
                    anchors.topMargin:6
                    width:roomcolumn.width * 0.96
                    text:areaname
                    onTextChanged: areaname = text
                }
            }
            }
            Item {
                width:parent.width
                height:locale.height + locale.y

            Text {
                text:i18n.tr("Discription:")
                color:"white"
                x:4
                font.pixelSize: roomcolumn.height * 0.025
                TextArea {
                    id:discription
                    anchors.top:parent.bottom
                    anchors.topMargin:6
                    width:roomcolumn.width * 0.96
                    height: roomcolumn.height / 3
                    text:discription

                }
            }
            }


        }
    }



}
