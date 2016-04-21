import QtQuick 2.4
import Ubuntu.Components 1.3
import "Main.js" as Scripts
import "openseed.js" as OpenSeed

import QtQuick.LocalStorage 2.0 as Sql



Rectangle {

    id:popup
    color:UbuntuColors.porcelain
    border.color:UbuntuColors.coolGrey
    border.width:10
    radius:8

    states: [
        State {
            name: "Show"
            PropertyChanges {
                target:popup
                visible:true
            }
        },
        State {
            name: "Hide"
            PropertyChanges {
                    target:popup
                    visible:false
            }
        }


    ]
    state:"Hide"

    Image {
        anchors.fill:parent
        //source:"graphics/wayfinder-big.png"
        source:"graphics/OpenSeed.png"
        opacity:0.05
        fillMode:Image.PreserveAspectFit
    }

    Column {
        anchors.verticalCenter: parent.verticalCenter
        width:parent.width

        spacing:13

        Text {
            text:i18n.tr("OpenSeed Connect")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: parent.width * 0.07
        }

        Rectangle {
            width:parent.width * 0.90
            height:parent.height * 0.01
            color:UbuntuColors.ash
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text:i18n.tr("WayFinder uses the OpenSeed network for background services. We ask for an email address but don't keep it. All transactions will be done through user IDs.")
            width:parent.width * 0.90
            wrapMode: Text.WordWrap
            x:parent.width * 0.05
            //font.pixelSize: parent.width * 0.05
        }

        Rectangle {
            width:parent.width * 0.90
            height:parent.height * 0.01
            color:UbuntuColors.ash
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text:i18n.tr("User Name")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: parent.width * 0.03
        }

        TextField {
            anchors.horizontalCenter: parent.horizontalCenter
            id:usernametext
            width:parent.width * 0.80
            text:username
            onTextChanged: username = text

        }

        Text {
            text:i18n.tr("Email Address")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: parent.width * 0.03
        }

        TextField {
            anchors.horizontalCenter: parent.horizontalCenter
            id:emailnametext
            width:parent.width * 0.80
            text:useremail
            onTextChanged: useremail = text
        }

    }

    Rectangle {
        id:okay
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.margins: 20
        width:parent.width * 0.20
        height:parent.height * 0.10
        border.color:UbuntuColors.ash
        radius:8

        Text {
            id:okaytext
            text:"Okay"
            font.pixelSize: parent.height / 2
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill:parent
            hoverEnabled: true
            onEntered: okay.color = UbuntuColors.coolGrey,okaytext.color = "white"
            onExited: okay.color = "white",okaytext.color = "black"
            onClicked: OpenSeed.oseed_auth(username,useremail),popup.state = "Hide"
        }
    }

    Rectangle {
        id:cancel
        anchors.left:parent.left
        anchors.bottom:parent.bottom
        anchors.margins: 20
        width:parent.width * 0.20
        height:parent.height * 0.10
        border.color:UbuntuColors.ash
        radius:8

        Text {
            id:canceltext
            text:"Cancel"
            font.pixelSize: parent.height / 2
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill:parent
            hoverEnabled: true
            onEntered: cancel.color = UbuntuColors.coolGrey,canceltext.color = "white"
            onExited: cancel.color = "white",canceltext.color = "black"
            onClicked: Qt.quit()
        }
    }
}
