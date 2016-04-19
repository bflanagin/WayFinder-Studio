import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Dialogs 1.0

Item {

    Text {
        anchors.top:parent.top
        anchors.topMargin:10
        x:10
        id:title
        text:i18n.tr("Settings:")
        color:"white"
        font.pixelSize: parent.height * 0.03
    }

    Rectangle {
        anchors.top:title.bottom
        anchors.topMargin:10
        x:10
        width:parent.width * 0.40
        height:(parent.height - title.height) * 0.95
        radius:8
        border.color:UbuntuColors.darkAubergine
        color:UbuntuColors.ash


        Column {
            y:20
            x:10
            spacing:20
            id:settingscolumn

            width:parent.width
            height:parent.height

            Text {
                text:i18n.tr("Store Name: ")
                color:"white"
                font.pixelSize: parent.height * 0.02
                TextField {
                    anchors.left:parent.right
                    width:(settingscolumn.width - parent.width) * 0.96
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Text {
                text:i18n.tr("Artist Name: ")
                color:"white"
                font.pixelSize: parent.height * 0.02
                TextField {
                    anchors.left:parent.right
                    width:(settingscolumn.width - parent.width) * 0.96
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                width:parent.width * 0.96
                height: 3
                color:UbuntuColors.darkAubergine
            }

            Item {
                    width:parent.width
                    height:discription.height
            Text {
                text:i18n.tr("Discription: ")
                color:"white"
                font.pixelSize: settingscolumn.height * 0.02

                TextArea {
                    id:discription
                    anchors.left:parent.right
                    width:(settingscolumn.width - parent.width) * 0.96
                    height:parent.height * 8
                    anchors.top: parent.top
                    wrapMode:Text.WordWrap
                }
            }

            }

            Text {
                text:i18n.tr("Contact Info: ")
                color:"white"
                font.pixelSize: parent.height * 0.02
                TextField {
                    anchors.left:parent.right
                    width:(settingscolumn.width - parent.width) * 0.96
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                width:parent.width * 0.96
                height: 3
                color:UbuntuColors.darkAubergine
            }

            Row {
                width:parent.width
                height:20
                spacing:30
                Text {
                    text:i18n.tr("Public: ")
                    font.pixelSize: parent.width * 0.03
                    color:"white"

                    CheckBox {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left:parent.right

                        id:pub
                    }
                }

                Text {
                    text:i18n.tr("Commissions: ")
                    font.pixelSize: parent.width * 0.03
                    color:"white"
                CheckBox {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left:parent.right
                    id:commisions
                }

                }

                Text {
                    text:i18n.tr("Donations: ")
                    font.pixelSize: parent.width * 0.03
                    color:"white"
                CheckBox {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left:parent.right
                    id:donations
                }

                }
            }

            Rectangle {
                width:parent.width * 0.96
                height: 3
                color:UbuntuColors.darkAubergine
            }

            Item {
                    width:parent.width
                    height:comoptscolumn.height


            Text {
                 id:comtitle
                text:i18n.tr("Payment Options: ")
                color:"white"
                font.pixelSize: parent.height * 0.02
                   visible: if(commisions.checked == 1 | donations.checked == 1 ) {true} else {false}

                Column {
                    id:comoptscolumn
                    anchors.top:parent.bottom
                    anchors.topMargin:20
                    anchors.left:parent.left
                    anchors.leftMargin:parent.width * 0.95
                    spacing:30
                    width:settingscolumn.width - parent.width
                    height:settingscolumn.height - parent.y


                    Text {
                        text:i18n.tr("Pay Pal: ")
                        color:"white"
                        font.pixelSize: parent.height * 0.025
                        TextField {
                            anchors.left:parent.right
                            width:(comoptscolumn.width - parent.width) * 0.96
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    Text {
                        text:i18n.tr("Patreon: ")
                        color:"white"
                        font.pixelSize: parent.height * 0.025
                        TextField {
                            anchors.left:parent.right
                            width:(comoptscolumn.width - parent.width) * 0.96
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    Text {
                        text:i18n.tr("CoinBase: ")
                        color:"white"
                        font.pixelSize: parent.height * 0.025
                        TextField {
                            anchors.left:parent.right
                            width:(comoptscolumn.width - parent.width) * 0.96
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                }



        }

            }


        }

    }

    Item {
        anchors.top:title.bottom
        anchors.topMargin:10
        anchors.right:parent.right
        anchors.rightMargin:20
        width:parent.width * 0.50
        height:(parent.height - title.height) * 0.95

        Image {
            id:avatar
            anchors.top:parent.top
            anchors.topMargin:10
            anchors.left:parent.left

            width:parent.width * 0.20
            height:parent.width * 0.20
            source:"graphics/newImageAdd.png"

        }
        Text {
           anchors.horizontalCenter:avatar.horizontalCenter
            anchors.top:avatar.bottom
            anchors.topMargin:10
            text:i18n.tr("Artist's Avatar")
            color:"white"
            font.pixelSize: parent.width * 0.02
        }

    Image {
        id:sample
        anchors.top:parent.top
        anchors.topMargin:10
        anchors.right:parent.right
        anchors.rightMargin:20
        width:parent.width * 0.70
        height:parent.height * 0.85
        source:"graphics/newImageAdd.png"

    }

    Text {
        anchors.horizontalCenter:sample.horizontalCenter
        anchors.top:sample.bottom
        anchors.topMargin:10
        text:i18n.tr("Sample Work")
        color:"white"
        font.pixelSize: parent.width * 0.03
    }

    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)

        }
        onRejected: {
            console.log("Canceled")

        }

    }


}
