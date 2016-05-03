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
    property string title:""
    property int inedit: 0
    property int hasedit: 0
    property string type: ""



    width:parent.width
    height:parent.height
    id:window_container
    clip:true


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
    id:window
    //z:0
    //width:parent.width * 0.99
    width:artwork.width + 10
    anchors.centerIn: parent
    //height:parent.height * 0.95
    height:artwork.height + 10
    radius:8
    color:UbuntuColors.coolGrey
    border.color:UbuntuColors.warmGrey
    clip:true




}

Rectangle {
    id:tag
    //z:1
    width:window.width * 0.10
    height:window.height * 0.06
    x:window.x
    anchors.bottom:window.top
    anchors.bottomMargin:-13
    radius:8
    color:UbuntuColors.coolGrey
    border.color:UbuntuColors.warmGrey

    Text {
        id:tagtext
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        anchors.topMargin:5
        text:title
        color:UbuntuColors.orange
    }

    Rectangle {
        width:parent.width
        height:parent.height * 0.4
        color:UbuntuColors.coolGrey
        y:parent.height * 0.75
        x:1.5
    }


}


Image {
    id:artwork
    anchors.centerIn: window_container
    //anchors.left:parent.left
    //z:1
    //anchors.top:tag.bottom
    //anchors.topMargin:10
    //anchors.leftMargin:30
    source:preview
    //width:parent.width * 0.70
    //height:parent.height * 0.90
    width:window_container.width * 0.80
    height:window_container.height * 0.90
    fillMode:Image.PreserveAspectFit

    MouseArea {
        anchors.fill:parent
        onClicked: inedit = 0;
        onPressAndHold: inedit = 1,hasedit = 1
    }

}

Rectangle {
    id:closebutton
    //z:2
    width:parent.height * 0.05
    height: width
    anchors.top:window.top
    anchors.right:window.right
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
        onClicked:{window_container.state = "Hide";
                    imagelist.clear();
                  if(hasedit == 1)
                        {fileio.store = "library,"+"file://"+preview,Scripts.store_img(type,fileio.store)}
                  Scripts.load_gallery();
                  hasedit = 0;
                  inedit = 0;
        }
            hoverEnabled: true
        onEntered: closebutton.color = "grey"
        onExited: closebutton.color = UbuntuColors.coolGrey

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
                 preview = fileio.store.split(":;:")[0];
                Scripts.store_img("library",fileio.store);
                break;
            case 2:

                fileio.store = "library,"+fileDialog.fileUrls;
                preview = fileio.store.split(":;:")[0];
                Scripts.store_img("private",fileio.store);
                break;

            default:break;

        }

    }
    onRejected: {
        console.log("Canceled")

    }

}


Rectangle {
    anchors.fill:options
    radius:8
    anchors.margins: -10
    color:UbuntuColors.warmGrey
    border.color:UbuntuColors.darkAubergine
    opacity:0.80
    //z:2
}

Column {
    id:options
    x:if(inedit == 0){window.width * 1.8} else {window.width - parent.width * 0.5}
    //z:2
    anchors.verticalCenter: window.verticalCenter
    width:parent.width * 0.40
    height:parent.height * 0.80
    spacing:8
    clip:true


    Item {
        width:parent.width
        height:titlespot.height + 20
    Text {
        text:"Title: "
        color:"white"
        font.pixelSize: parent.width * 0.05
        TextField {
            id:titlespot
           // height:parent.height
            width:options.width - parent.width
            text:title
            onTextChanged: title
            anchors.left:parent.right
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

    }

       }


    ComboButton {
        id:artclass
        width:parent.width
        //height:window.height * 0.10
        text:if(aclass == ""){"Class"} else {aclass}
        onTextChanged: aclass = text
        GridView {
                width:parent.width
                cellWidth: parent.width * 0.98
                cellHeight: parent.height * 0.20
                model: ["Item","Weapon","Concept Art","Creature",
                    "------------------------------------------------------------------","Fighter","Wizard","Rogue"]
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


Image {
    source:"/usr/share/icons/suru/actions/scalable/delete.svg"
    anchors.bottom:window.bottom
    anchors.right:window.right
    anchors.margins: 10
    width:window.width * 0.10
    height:window.height * 0.10
    fillMode:Image.PreserveAspectFit

    MouseArea {
        anchors.fill: parent
        onClicked: Scripts.delete_img(preview),window_container.state = "Hide",Scripts.load_gallery()
    }

}


}
