import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.1
import "Main.js" as Scripts

import QtQuick.LocalStorage 2.0 as Sql

Item {
    property string areaname: "No Name"
    property int zoomlevel: 1
    property string discription: ""

    onZChanged: Scripts.mapgrid()


    Timer {
        id:autowaller
        running:true
        repeat:true
        interval:1000
        //onTriggered:Scripts.autowall();

    }

    Timer {
        id:autosave
        running:false
        repeat:true
        interval:5000
        onTriggered:Scripts.save_map()

    }

    Rectangle {
        color:UbuntuColors.warmGrey
        anchors.fill:mapflick
        anchors.margins: -10
        radius:8
    }
    Flickable {
            id:mapflick
        width:parent.width * 0.80
        height:parent.height * 0.95
        anchors.left:parent.left
        anchors.leftMargin:20
        anchors.verticalCenter: parent.verticalCenter
        contentHeight: maparea.height * 1.2
        contentWidth:maparea.width
        clip:true
        //interactive:false



        Item {
            id:maparea
            width:parent.width * zoomlevel
            height:parent.width * zoomlevel
        }

    }

    Item {
        anchors.bottom:parent.bottom
        anchors.margins:20
        anchors.left: parent.left
        height:parent.height * 0.10
        width:parent.width * 0.20

        Rectangle {
            color:UbuntuColors.coolGrey
            border.color:Qt.rgba(0.5,0.5,0.5,0.5)
            border.width:4
            anchors.fill:parent
        }

    Text {
        anchors.top:parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        id:title
        text:i18n.tr("Map - "+maptitle)
        color:"white"
        font.pixelSize: parent.height * 0.2
    }

    Rectangle {
        color:{
            switch(current_base) {
            case 1: "#034405";break;
            case 2: Qt.rgba(0.5,0.3,0.1,1);break;
            case 3:"#ACA069";break;
            case 4:"#86c6fd";break;
            case 5:"#d4d8dc";break;
            default:"white";break;
        }
        }
        anchors.left:parent.left
        anchors.leftMargin:10
        anchors.verticalCenter: parent.verticalCenter
        width:parent.width * .15
        height:parent.width * .15
        border.color:"grey"

        Text {
            anchors.left:parent.right
            anchors.leftMargin:2
            anchors.top:parent.top
            color:"white"
            text:{
            switch(current_base) {
                case 1: i18n.tr("Living");break;
                case 2: i18n.tr("Soil");break;
                case 3: i18n.tr("Sand");break;
                case 4: i18n.tr("Ice");break;
                case 5: i18n.tr("Rock");break;
                default:i18n.tr("No Base Texture");break;
                }
             }


            Text {
                anchors.left:parent.left

                anchors.top:parent.bottom
                color:"white"
                text:{
                switch(current_cf) {
                    case 1: i18n.tr("Standard Terrain");break;
                    case 2: i18n.tr("Ruff Terrain");break;
                    case 3: i18n.tr("Shallow Water");break;
                    case 4: i18n.tr("Deep Water");break;
                    case 5: i18n.tr("Tainted Water");break;
                    case 6: i18n.tr("Deadly Fluid");break;
                    default:i18n.tr("No Terrain");break;
                    }
                 }

                Text {
                    anchors.left:parent.left

                    anchors.top:parent.bottom
                    color:"white"
                    text:{
                    switch(current_cw) {
                        case 1: i18n.tr("Wall");break;
                        case 2: i18n.tr("Wall");break;
                        case 3: i18n.tr("Wall");break;
                        case 4: i18n.tr("Wall");break;
                        case 5: i18n.tr("Wall");break;
                        case 6: i18n.tr("Wall");break;
                        case 7: i18n.tr("Wall");break;
                        case 8: i18n.tr("Wall");break;
                        case 9: i18n.tr("Wall");break;
                        case 10: i18n.tr("Wall");break;
                        case 11: i18n.tr("Wall");break;
                        case 12: i18n.tr("Wall");break;
                        default:i18n.tr("No Wall");break;
                        }
                     }
                    }


                }


            }
          }

        Image {
            z:1
            anchors.top:parent.top
            anchors.right:parent.right
            anchors.margins:10
            source:if(quickfill == 1) {"graphics/multi.png"} else {"graphics/single.png"}
            width:parent.width * 0.10
            height:parent.width * 0.10
        }

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
                    text:maptitle
                    onTextChanged: maptitle = text,autosave.running = true;
                }
            }
            }
            Item {
                width:parent.width
                height:discription.height + discription.y

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
                    text:mapdiscription
                    onTextChanged: mapdiscription = text,autosave.running = true;

                }
            }
            }
            Item {
                width:parent.width
                height:enemies.height + enemies.y + 10
                clip:true

            Text {
                text:i18n.tr("Enemies:")
                color:"white"
                x:4
                font.pixelSize: roomcolumn.height * 0.025

                Rectangle {
                    anchors.centerIn: enemies
                    width:enemies.width
                    height:enemies.height * 1.08
                    color:"white"
                    radius:8
                }


                GridView {
                    id:enemies
                    width:roomcolumn.width * 0.96
                    height: roomcolumn.height * 0.20
                    anchors.top:parent.bottom
                    anchors.topMargin:8
                    cellWidth:roomcolumn.width *0.96
                    cellHeight:roomcolumn.height * 0.05

                    clip:true

                    delegate:
                        Image {
                            source:img
                            width:enemies.cellWidth
                            height:enemies.cellHeight * 0.95



                        Text {
                            text:name
                            anchors.centerIn: parent
                        }
                        MouseArea {
                            anchors.fill:parent
                            onClicked:console.log(name)
                        }

                    }


                    model: ListModel {
                        id:enemylist


                    ListElement {
                        name:"Add new"
                        img:"graphics/newImageAdd.png"
                    }


                    }

                }



            }

           }

            Item {
                width:parent.width
                height:items.height + items.y + 10
                clip:true

            Text {
                text:i18n.tr("Items:")
                color:"white"
                x:4
                font.pixelSize: roomcolumn.height * 0.025

                Rectangle {
                    anchors.centerIn: items
                    width:items.width
                    height:items.height * 1.08
                    color:"white"
                    radius:8
                }


                GridView {
                    id:items
                    width:roomcolumn.width * 0.96
                    height: roomcolumn.height * 0.20
                    anchors.top:parent.bottom
                    anchors.topMargin:8
                    cellWidth:roomcolumn.width *0.96
                    cellHeight:roomcolumn.height * 0.05

                    clip:true

                    delegate:
                        Image {
                            source:img
                            width:items.cellWidth
                            height:items.cellHeight * 0.95



                        Text {
                            text:name
                            anchors.centerIn: parent
                        }
                        MouseArea {
                            anchors.fill:parent
                            onClicked:console.log(name)
                        }

                    }


                    model: ListModel {
                        id:itemlist


                    ListElement {
                        name:"Add new"
                        img:"graphics/newImageAdd.png"
                    }


                    }

                }



            }

           }



        }
    }


    MapTools {
        id:toolbox
        state:"Show"
        x:parent.width * 0.60
        width:parent.width * 0.13
        height:parent.width * 0.13

    }

}
