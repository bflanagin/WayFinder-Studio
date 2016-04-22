import QtQuick 2.4
import Ubuntu.Components 1.3
//import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.0

import WayFinder 1.0

import QtQuick.LocalStorage 2.0 as Sql

import "Main.js" as Scripts
import "openseed.js" as OpenSeed



Item {


    property int where: 1
    property string preview: ""


    width:parent.width
    height:parent.height
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

    onStateChanged: if(window_container.state == "Show") {race ="",aclass="",artdiscription="",download=1,cost="0.00",base=0,preview=""}

Rectangle {
    id:window
    z:0
    width:parent.width * 0.99
    anchors.centerIn: parent
    height:parent.height * 0.95
    radius:8
    color:UbuntuColors.coolGrey
    border.color:UbuntuColors.warmGrey

    Rectangle {
        anchors.fill:options
        radius:8
        anchors.margins: -10
        color:UbuntuColors.warmGrey
        border.color:UbuntuColors.darkAubergine
    }

    Column {
        id:options
        y:tag.height
        x:20
        width:parent.width * 0.40
        height:parent.height * 0.90
        spacing:8


        Item {
            width:parent.width
            height:titlespot.height + 10
        Text {
            text:"Title: "
            color:"white"
            font.pixelSize: parent.width * 0.05
            TextField {
                id:titlespot
               // height:parent.height
                width:options.width - parent.width
                text:artname
                onTextChanged: artname = text
                anchors.left:parent.right
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

        }

           }


        ComboButton {

            id:artrace
            text:if(race == ""){"Race"} else {race}
            onTextChanged: race = text
            width:parent.width
            expanded: false
            //height:window.height * 0.10
            ListView {
                    model: ["Elf","Human","Dwarf"]
                    spacing:5
                    delegate:

                       Text {

                        horizontalAlignment: Text.AlignHCenter
                        text: modelData
                        width:parent.width


                        MouseArea {
                            anchors.fill:parent
                            onClicked: {artrace.text = modelData
                                        artrace.expanded = false}
                        }
                    }

            }
        }
        ComboButton {
            id:artclass
            width:parent.width
            //height:window.height * 0.10
            text:if(aclass == ""){"Class"} else {aclass}
            onTextChanged: aclass = text
            ListView {
                    spacing:5
                    model: ["Fighter","Wizard","Rogue"]
                    delegate:

                        Text {

                        horizontalAlignment: Text.AlignHCenter
                        text: modelData
                        width:parent.width


                        MouseArea {
                            anchors.fill:parent
                            onClicked: {artclass.text = modelData
                                        artclass.expanded = false}
                        }
                    }
            }

        }
        Text {
            text:"Download: "
            color:"white"
            font.pixelSize: parent.width * 0.05
            CheckBox {
               // height:parent.height
               // width:parent.height
                id:downloadcheck
                checked:if(download == 1) {return true} else {return false}
                onCheckedChanged: download = checked
                anchors.left:parent.right
                anchors.verticalCenter: parent.verticalCenter
            }

        }
        Text {
            text:"Cost: "
            color:"white"
            font.pixelSize: parent.width * 0.05
            TextField {
               // height:parent.height
                width:options.width - parent.width
                text:cost
                onTextChanged: cost = text
                anchors.left:parent.right
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

        }

        Text {
            text:"Base Image: "
            color:"white"
            font.pixelSize: parent.width * 0.05
            CheckBox {
                id:artbase
                anchors.left:parent.right
                anchors.verticalCenter: parent.verticalCenter
                checked:if(base == 1) {return true} else {return false}
                onCheckedChanged: base = checked;
            }

        }

        Text {
            text:"Discription:"
            color:"white"
            font.pixelSize: parent.width * 0.05

            TextArea {
                anchors.top:parent.bottom
                anchors.topMargin:10
                width:options.width
                height: window.height / 2.5
                text:artdiscription
                onTextChanged: artdiscription = text
            }
        }

    }


}

Image {
    anchors.right:parent.right
    anchors.top:tag.bottom
    anchors.topMargin:10
    anchors.rightMargin:30
    source:if(preview == "") {"graphics/newImageAdd.png"} else {preview}
    width:parent.width * 0.40
    height:parent.height * 0.88
    fillMode:if(preview == "") {Image.PreserveAspectFit} else {Image.PreserveAspectCrop}

    MouseArea {
        anchors.fill:parent
        onClicked: fileDialog.open()
    }

}

Rectangle {
    id:closebutton
    width:parent.height * 0.05
    height: width
    anchors.top:parent.top
    anchors.right:parent.right
    anchors.margins: 3
    radius: width / 2
    border.color:"gray"
    color:UbuntuColors.coolGrey

    Text {
        text:"X"
        anchors.centerIn: parent
        color:"white"
    }
    MouseArea {
        anchors.fill:parent
        onClicked:window_container.state = "Hide",imagelist.clear(),Scripts.load_gallery()
        hoverEnabled: true
        onEntered: closebutton.color = "grey"
        onExited: closebutton.color = UbuntuColors.coolGrey

    }
}


Rectangle {
    id:tag
    z:1
    width:window.width * 0.10
    height:parent.height * 0.06
    x:window.x
    y:window.y * - 0.7
    radius:8
    color:UbuntuColors.coolGrey
    border.color:UbuntuColors.warmGrey

    Text {
        id:tagtext
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        anchors.topMargin:5
        text:i18n.tr("New Art")
        color:UbuntuColors.orange
    }

    Rectangle {
        width:parent.width
        height:parent.height * 0.4
        color:UbuntuColors.coolGrey
        y:parent.height * 0.75
        x:1
    }


}

FileDialog {
    id: fileDialog

    title: "Please choose a file"
    //folder: shortcuts.home
    property string imagefile: ""
    onAccepted: {
            switch(where) {
            case 1:

                fileio.store = "library,"+fileDialog.fileUrls;
                 preview = fileio.store;
                Scripts.store_img("library",preview);
                break;
            case 2:

                fileio.store = "library,"+fileDialog.fileUrls;
                preview = fileio.store;
                Scripts.store_img("private",preview);
                break;

            default:break;

        }

    }
    onRejected: {
        console.log("Canceled")

    }

}


}
