import QtQuick 2.4
import Ubuntu.Components 1.3
//import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.0


Item {
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
        spacing:10
        clip:true

        ComboButton {

            id:artrace
            text:"Race"
            width:parent.width
            //height:window.height * 0.10
            ListView {
                    model: ["Elf","Human","Dwarf"]
                    delegate: Text {
                        text: modelData
                    }
            }
        }
        ComboButton {
            id:artclass
            width:parent.width
            //height:window.height * 0.10
            text:"Class"
            ListView {
                    model: ["Fighter","Wizard","Rogue"]
                    delegate: Text {
                        text: modelData
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
                checked:true
                anchors.left:parent.right
                anchors.verticalCenter: parent.verticalCenter
            }

        }
        Text {
            text:"Cost: "
            color:"white"
            font.pixelSize: parent.width * 0.05
            TextField {
                height:parent.height
                width:options.width - parent.width
                id:cost

                anchors.left:parent.right
                anchors.verticalCenter: parent.verticalCenter
            }

        }

        Text {
            text:"Base Image: "
            color:"white"
            font.pixelSize: parent.width * 0.05
            CheckBox {
                id:base

                anchors.left:parent.right
                anchors.verticalCenter: parent.verticalCenter
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
                height: window.height / 2
            }
        }

    }


}

Image {
    anchors.right:parent.right
    anchors.top:tag.bottom
    anchors.topMargin:10
    anchors.rightMargin:30
    source:"graphics/newImageAdd.png"
    width:parent.width * 0.40
    height:parent.height * 0.88

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
        onClicked:window_container.state = "Hide"
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
    onAccepted: {
        console.log("You chose: " + fileDialog.fileUrls)

    }
    onRejected: {
        console.log("Canceled")

    }

}


}
