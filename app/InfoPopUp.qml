import QtQuick 2.4
import Ubuntu.Components 1.3
import WayFinder 1.0

import QtQuick.LocalStorage 2.0 as Sql

import QtQuick.Controls 1.4

import "Main.js" as Scripts
import "openseed.js" as OpenSeed

Item {
   // width:parent.width
  //  height:parent.height
    id:window_container
    clip:true
    property string dbsource: "none"
    property string search: " "
    property int mode:0

    MouseArea {
        anchors.fill:parent
        hoverEnabled: true
        onExited: if(window_container.state !="Edit") {infoview.state = "Hide"}
        onClicked: if(window_container.state !="Edit") {infoview.state = "Hide"}
    }

    states: [

        State {
            name:"Show"

            PropertyChanges {
                target:window_container
                visible:true
                mode:0
            }

        },
        State {
            name:"Hide"

            PropertyChanges {
                target:window_container
                visible:false
                mode:0

            }
        },
        State {
            name:"Edit"

            PropertyChanges {
                target:window_container
                visible:true
                width:width * 1.5
                height:height * 1.5
                mode:1

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

Rectangle {
    anchors.top:parent.top
    anchors.right:parent.right
    anchors.margins: parent.width * 0.02
    radius:8
    width:parent.width * 0.1
    height:parent.width * 0.1
    color:UbuntuColors.coolGrey

    Image {
        anchors.centerIn: parent
        source:"/usr/share/icons/suru/actions/scalable/edit.svg"
        width:parent.width * 0.9
        height:parent.width * 0.9
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        anchors.fill:parent
        hoverEnabled: true
        onEntered:if(mode == 0) {parent.color = "grey",infoview.state = "Show"} else {parent.color = "grey",infoview.state = "Edit"}
        onExited:parent.color = UbuntuColors.coolGrey
        onClicked: if(mode == 0) {parent.color = UbuntuColors.coolGrey,window_container.state = "Edit"} else {console.log("Missing Save Command"),window_container.state = "Show"}
    }
}

Rectangle {
    anchors.top:parent.top
    anchors.left:parent.left
    anchors.margins: parent.width * 0.02
    radius:8
    width:parent.width * 0.1
    height:parent.width * 0.1
    color:UbuntuColors.coolGrey
    visible:if(mode == 0) {false} else {true}

    Image {
        anchors.centerIn: parent
        source:"/usr/share/icons/suru/actions/scalable/close.svg"
        width:parent.width * 0.9
        height:parent.width * 0.9
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        anchors.fill:parent
        hoverEnabled: true
        onEntered:parent.color = "grey"
        onExited:parent.color = UbuntuColors.coolGrey
        //onClicked: if(mode == 0) {parent.color = UbuntuColors.coolGrey,window_container.state = "Edit"} else {console.log("Missing Save Command"),window_container.state = "Show"}
    }
}

Column {
    anchors.centerIn:if( mode == 1 || mode == 0) {parent}
    width:parent.width * 0.90
    height:parent.height* 0.90

    spacing:5

    Image {
        source:"graphics/map/enemy.png"
        anchors.horizontalCenter: parent.horizontalCenter
        visible:if(mode == 0) {true} else {false}

        Text {
            anchors.top:parent.top
            anchors.right:parent.right
            text:"11"
            color:"white"

        }
    }

    Image {
        source:"graphics/map/enemy.png"
        visible:if(mode == 1) {true} else {false}
        height:parent.height * 0.4
        width:parent.width * 0.4
        fillMode: Image.PreserveAspectFit

    Column {
            anchors.left:parent.right
            anchors.top:parent.top
            width:window_container.width - parent.width - parent.y
            spacing:parent.height * 0.1

            Text {
                x:parent.width * 0.08
                text:"Ghost Name"
                color:"white"

            }
            Text {
                x:parent.width * 0.08
                text:"(Ghost)"
                color:"white"

            }

        Text {
            text:"Lvl:"
            color:"white"

        TextField {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left:parent.right
            placeholderText:"11"
            maximumLength: 2
            width:parent.width *1.5
        }

        }

        Text {

            text:"HP:"
            color:"white"

        TextField {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left:parent.right
            placeholderText:"11"
            maximumLength: 8
            width:parent.width * 5
        }

        }



         }
    }

    Text {
         x:parent.width * 0.08
        text:"HP: "+"10"
        color:"white"
        visible:if(mode == 0) {true} else {false}
    }

    Text {
        x:parent.width * 0.08
        text:"AC: "+"10"+" | TAC: "+"20"+" | FF: "+"14"
        color:"white"
        visible:if(mode == 0) {true} else {false}
    }

    Row {
        width:parent.width
        visible:if(mode == 1) {true} else {false}
        spacing: 8

        Item {
           width:acfield.width + acfield.x
           height:acfield.height
         Text {

             text:"AC:"
             color:"white"

          TextField {
              id:acfield
              anchors.verticalCenter: parent.verticalCenter
              anchors.left:parent.right
              placeholderText:"11"
              maximumLength: 2
              width:parent.width *2
                }
             }
        }
        Item {
            width:tacfield.width + tacfield.x
            height:tacfield.height
         Text {

             text:"TAC:"
             color:"white"

          TextField {
              id:tacfield
              anchors.verticalCenter: parent.verticalCenter
              anchors.left:parent.right
              placeholderText:"11"
              maximumLength: 2
              width:acfield.width
             }

            }
        }

        Item {
            width:fffield.width + fffield.x
            height:fffield.height
         Text {

             text:"FF:"
             color:"white"

          TextField {
              id:fffield
              anchors.verticalCenter: parent.verticalCenter
              anchors.left:parent.right
              placeholderText:"11"
              maximumLength: 2
              width:acfield.width
             }

             }
        }

    }

    Text {
        x:parent.width * 0.08
        text:"WS: "+"30"+" | FS: "+"0"+" | RS: "+"4"
        color:"white"
        visible:if(mode == 0) {true} else {false}
    }
    Row {
        width:parent.width
        visible:if(mode == 1) {true} else {false}
        spacing: 8

        Item {
           width:wsfield.width + wsfield.x
           height:wsfield.height
         Text {

             text:"WS:"
             color:"white"

          TextField {
              id:wsfield
              anchors.verticalCenter: parent.verticalCenter
              anchors.left:parent.right
              placeholderText:"11"
              maximumLength: 2
              width:parent.width *2
                }
             }
        }
        Item {
            width:fsfield.width + fsfield.x
            height:fsfield.height
         Text {

             text:"FS:"
             color:"white"

          TextField {
              id:fsfield
              anchors.verticalCenter: parent.verticalCenter
              anchors.left:parent.right
              placeholderText:"11"
              maximumLength: 2
              width:wsfield.width
             }

            }
        }

        Item {
            width:rsfield.width + rsfield.x
            height:rsfield.height
         Text {

             text:"RS:"
             color:"white"

          TextField {
              id:rsfield
              anchors.verticalCenter: parent.verticalCenter
              anchors.left:parent.right
              placeholderText:"11"
              maximumLength: 2
              width:wsfield.width
             }

             }
        }

    }
    Text {
        x:parent.width * 0.08
        text:"Discription:\n"+"OoOoO! I'm a ghosty. OoOoO!"
        width:parent.width - (parent.width * 0.08)
        wrapMode:Text.WordWrap
        color:"white"
        visible:if(mode == 0) {true} else {false}
    }
    TextArea {
        x:parent.width * 0.01
        height:parent.height - y
        width:parent.width * 0.99
        text:"OoOoO! I'm a ghosty. OoOoO!"

        visible:if(mode == 1) {true} else {false}
    }
}


}
