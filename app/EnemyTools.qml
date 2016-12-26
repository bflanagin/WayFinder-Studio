import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.1
import "Main.js" as Scripts


Item {
property int where: 1
property string preview: ""
    property int mode: 0


//width:parent.width
//height:parent.height
id:window_container



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

onStateChanged: if(window_container.state == "Show") {}


Rectangle {
    color:UbuntuColors.coolGrey
    anchors.fill:parent
    radius:8
    border.color:Qt.rgba(0.4,0.4,0.4,0.8)
    border.width:10
    clip:true


    Rectangle {
        id:closebutton
        anchors.left: parent.left
        anchors.top:parent.top
        width:parent.height * 0.2
        height:parent.height * 0.2
        radius: 8
        border.color: "grey"
        color:UbuntuColors.coolGrey


        Image {
            source:"graphics/gear.png"
            anchors.centerIn: parent
            width:parent.width * 0.80
            height:parent.width * 0.80
            fillMode:Image.PreserveAspectFit
        }

        MouseArea {
            anchors.fill:parent
            onPressed:closebutton.color = "grey"
            drag.target: window_container
            drag.axis: Drag.XAndYAxis
            drag.minimumX: 0
            drag.minimumY: 0
            drag.maximumX: mapflick.width - window_container.width
            drag.maximumY: mapflick.height - window_container.height

            hoverEnabled: true
            onEntered: closebutton.color = "grey"
            onExited: closebutton.color = UbuntuColors.coolGrey

            onClicked:if(mode == 0) {mode = 1} else {mode = 0}
        }
    }

    Text {
        id:title
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter:closebutton.verticalCenter
        color:"white"
        font.pixelSize: parent.height * 0.1
        text:if(mode == 0) {i18n.tr("Enemy")} else {i18n.tr("Friendly") }
             }

    GridView {
        id:enemygrid
        anchors.top:closebutton.bottom
        anchors.topMargin:parent.height * 0.01
        x:parent.width * 0.05
        width:parent.width * 0.94
        height:parent.height - closebutton.height - closebutton.height
        cellHeight: width * 0.2
        cellWidth: width * 0.2
        clip:true
        delegate: Item {
                    width:enemygrid.cellWidth * 0.90
                    height: enemygrid.cellHeight * 0.90

                    Rectangle {
                        id:enemyborder
                        anchors.fill:parent
                        color:Qt.rgba(0.4,0.4,0.4,0.0)
                        border.color: if(current_enemy == enemy) {"gold"} else {"grey"}
                    }
                    Image {
                        width:parent.width * 0.90
                        height:parent.height * 0.90
                        anchors.centerIn: parent
                        source:enemyimage
                        fillMode:Image.PreserveAspectFit
                    }

                    MouseArea {
                        anchors.fill:parent
                        onClicked:{ current_enemy = enemy
                                        enemy_size = size
                                   monstersize.running = true
                                    }
                    }

                }

        model: ListModel {
            id:actorslist

            ListElement {
                enemyimage:"graphics/enemies/redg.png"
                enemy: 1
                size: 1
            }
            ListElement {
                enemyimage:"graphics/enemies/blueg.png"
                enemy: 2
                size: 2
            }
            ListElement {
                enemyimage:"graphics/enemies/greeng.png"
                enemy: 3
                size: 3
            }
            ListElement {
                enemyimage:"graphics/enemies/yellowg.png"
                enemy: 4
                size: 4
            }
            ListElement {
                enemyimage:"graphics/enemies/purpleg.png"
                enemy: 5
                size: 6
            }

        }




    }

    Text {
        text:i18n.tr("Search: ")
        color:"white"
        anchors.left:parent.left
        anchors.bottom: parent.bottom
        anchors.margins:parent.height * 0.06
        font.pixelSize:closebutton.height * 0.60

        TextField {
            id:searchfield
            anchors.left:parent.right
            anchors.verticalCenter: parent.verticalCenter
            width:(window_container.width - parent.width - closebutton.width) * 0.98
        }
    }


}






}
