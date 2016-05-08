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



    onStateChanged: if(window_container.state == "Show"){levels();lvllist.setProperty(0,"selected","darkorange")} else {}




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
        text:i18n.tr("Codex")
        color:UbuntuColors.orange
    }


}
Rectangle {
    id:sortandsearch
    width:window.width
    height:window.height * 0.05
    anchors.top:window.top
    anchors.topMargin:10
    anchors.horizontalCenter: window.horizontalCenter
    color:UbuntuColors.coolGrey

Text {
    anchors.left:parent.left
    anchors.leftMargin:10
    text: i18n.tr("Sort: ")
    color:"white"
    font.pixelSize: parent.height * 0.6
    anchors.verticalCenter: parent.verticalCenter

    ComboBox {
        id:codexsort
        anchors.left:parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: 200
        model: [ "Potion", "Apple", "Coconut" ]
    }

}

TextField {
    anchors.right:parent.right
    anchors.rightMargin:10

    anchors.verticalCenter: parent.verticalCenter

    width: parent.width * 0.30

    Text {
        anchors.right:parent.left

        anchors.verticalCenter: parent.verticalCenter
    text: i18n.tr("Search: ")
    color:"white"
    font.pixelSize: parent.height
    }


}

}

Item {
    id:lvlcontainer
    anchors.top:sortandsearch.bottom
    anchors.topMargin:10
    anchors.horizontalCenter: window.horizontalCenter
    width:window.width
    height:window.height * 0.03
    clip:true

    GridView{
        id:lvlgrid

        width:parent.width
        height:parent.height
        cellHeight: height * 0.90
        cellWidth: width * 0.02
        flow: GridView.FlowTopToBottom

        //clip:true

        delegate:
            Item {
                width:lvlgrid.cellWidth * 0.90
                height:lvlgrid.cellHeight * 0.80


                    Text {
                        id:index
                     text:name
                     anchors.horizontalCenter: parent.horizontalCenter
                     font.pixelSize: parent.height
                     color:selected
                    }

                    MouseArea {
                        anchors.fill:parent
                        onClicked:clear_levels(),lvllist.setProperty(name-1,"selected","darkorange"),clvl =name-1;
                    }

                }


        model: ListModel {
                id: lvllist






        }

    }

}


Item {
    anchors.top:lvlcontainer.bottom
    anchors.topMargin:10
    anchors.horizontalCenter: window.horizontalCenter
    width:window.width
    height:window.height - lvlcontainer.height - lvlcontainer.y
    //clip:true

    Rectangle {
        anchors.centerIn: codexgrid
        width:codexgrid.width * 1.01
        height:codexgrid.height * 1.02
        radius:8
        border.color:"white"
        color:UbuntuColors.coolGrey

        Image {
            anchors.fill:parent
            fillMode:Image.PreserveAspectFit
            source:"/usr/share/icons/suru/actions/scalable/bookmark.svg"
            opacity:0.10
        }
    }

    GridView {
        id:codexgrid
        anchors.horizontalCenter: parent.horizontalCenter


        width:parent.width * 0.98
        height:parent.height * 0.99
        cellHeight: height * 0.10
        cellWidth: width * 0.50

        //flow: GridView.FlowTopToBottom

        clip:true

        delegate:
            Item {
                width:codexgrid.cellWidth
                height:codexgrid.cellHeight

                Rectangle {
                    id:itemback
                    width:parent.width * 0.99
                    height:parent.height
                    border.color:"gray"
                    color:if(index % 3 != 0){UbuntuColors.coolGrey} else {UbuntuColors.inkstone}
                    clip:true
                    anchors.horizontalCenter: parent.horizontalCenter

                Row {
                    width:parent.width
                    height:parent.height
                    spacing:5


                    Image {
                        width: codexgrid.cellheight * 0.98
                        height: codexgrid.cellheight * 0.98
                        source:"graphics/map/items.png"
                        fillMode:Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                        }

                    Text {
                     text:name
                     anchors.verticalCenter: parent.verticalCenter
                     font.pixelSize: (parent.height -text.length) * 0.50
                     color:"white"
                     width:codexgrid.cellWidth * 0.33
                     wrapMode: Text.WordWrap
                    }
                    Rectangle {
                     width:codexgrid.cellHeight * 0.01
                     height:codexgrid.cellHeight * 0.98
                     anchors.verticalCenter: parent.verticalCenter
                     color:"white"
                    }
                    Text {
                     text:cdiscription

                     //anchors.verticalCenter: parent.verticalCenter
                     font.pixelSize: (parent.height -text.length) * 0.30
                     color:"white"
                     width:codexgrid.cellWidth * 0.25
                     wrapMode: Text.WordWrap
                    }

                }

              }

                MouseArea {
                    anchors.fill:parent
                    hoverEnabled: true
                    onEntered:itemback.color = UbuntuColors.ash
                    onExited: if(index % 3 != 0){itemback.color = UbuntuColors.coolGrey} else {itemback.color = UbuntuColors.inkstone}
                    onClicked: article.state = "Show",article.name = name


                }

                }


        model: ListModel {
                id: codexlist


                ListElement {
                    name:"Potion of Lesser Restoration"
                    cdiscription:"Does stuff"
                }

                ListElement {
                    name:"Potion of Greater Restoration"
                    cdiscription:"Does More stuff"
                }
                ListElement {
                    name:"Potion of Lesser Degeneration"
                    cdiscription:"Does Bad stuff"
                }
                ListElement {
                    name:"Potion of Greater Degeneration"
                    cdiscription:"Does Really Bad stuff"
                }


        }

    }

}


Article {
    id:article
    width:parent.width * 0.70
    height:parent.height * 0.90
    anchors.centerIn: parent
    state:"Hide"

}






function levels() {

    var num = 1;
    while(num < 60) {
        lvllist.append ({
                        name:num,
                        selected:"white"

                        });

        num =num+1;

    }


}

function clear_levels() {

    var num = 0;
    while(num < 59) {
        lvllist.setProperty(num,"selected","white");

        num =num+1;

    }


}

}
