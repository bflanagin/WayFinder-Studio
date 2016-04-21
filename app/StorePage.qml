import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Dialogs 1.0

import QtQuick.LocalStorage 2.0 as Sql
import "Main.js" as Scripts
import "openseed.js" as OpenSeed

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
                    text:storename
                    onTextChanged: storename = text
                    anchors.left:parent.right
                    width:(settingscolumn.width - parent.width) * 0.96
                    anchors.verticalCenter: parent.verticalCenter
                    onFocusChanged:  Scripts.artuserdb("save");
                }
            }

            Text {
                text:i18n.tr("Artist Name: ")
                color:"white"
                font.pixelSize: parent.height * 0.02
                TextField {
                    text:artistname
                    onTextChanged: artistname = text
                    anchors.left:parent.right
                    width:(settingscolumn.width - parent.width) * 0.96
                    anchors.verticalCenter: parent.verticalCenter
                    onFocusChanged:  Scripts.artuserdb("save");
                }
            }

            Rectangle {
                width:parent.width * 0.96
                height: 3
                color:UbuntuColors.darkAubergine
            }

            Item {
                    width:parent.width
                    height:discript.height
            Text {
                text:i18n.tr("Discription: ")
                color:"white"
                font.pixelSize: settingscolumn.height * 0.02

                TextArea {
                    id:discript
                    text:discription
                    onTextChanged: discription = text
                    anchors.left:parent.right
                    width:(settingscolumn.width - parent.width) * 0.96
                    height:parent.height * 8
                    anchors.top: parent.top
                    wrapMode:Text.WordWrap
                    onFocusChanged:  Scripts.artuserdb("save");
                }
            }

            }

            Text {
                text:i18n.tr("Contact Info: ")
                color:"white"
                font.pixelSize: parent.height * 0.02
                TextField {
                    text:contact
                    onTextChanged: contact = text
                    anchors.left:parent.right
                    width:(settingscolumn.width - parent.width) * 0.96
                    anchors.verticalCenter: parent.verticalCenter
                     onFocusChanged:  Scripts.artuserdb("save");
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
                         onFocusChanged:  Scripts.artuserdb("save");
                        checked:if(pub == 1) {return true} else {return false}
                        onCheckedChanged: pub = checked
                    }
                }

                Text {
                    text:i18n.tr("Commissions: ")
                    font.pixelSize: parent.width * 0.03
                    color:"white"
                CheckBox {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left:parent.right
                    checked:if(commissions == 1) {return true} else {return false}
                    onCheckedChanged: commissions = checked
                    onFocusChanged:  Scripts.artuserdb("save");
                }

                }

                Text {
                    text:i18n.tr("Donations: ")
                    font.pixelSize: parent.width * 0.03
                    color:"white"
                CheckBox {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left:parent.right
                    checked:if(donations == 1) {return true} else {return false}
                    onCheckedChanged: donations = checked
                     onFocusChanged:  Scripts.artuserdb("save");
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
                    visible: if(commissions == 1 | donations == 1 ) {true} else {false}


            Text {
                 id:comtitle
                text:i18n.tr("Payment Options: ")
                color:"white"
                font.pixelSize: settingscolumn.height * 0.02


                Column {
                    id:comoptscolumn
                    anchors.top:parent.bottom
                    anchors.topMargin:20
                    anchors.left:parent.left
                    anchors.leftMargin:parent.width * 0.95
                    spacing:30
                    width:settingscolumn.width - parent.width
                    //height:settingscolumn.height - parent.y


                    Text {
                        text:i18n.tr("Pay Pal: ")
                        color:"white"
                        font.pixelSize: settingscolumn.height * 0.025
                        TextField {
                            anchors.left:parent.right
                            width:(comoptscolumn.width - parent.width) * 0.96
                            anchors.verticalCenter: parent.verticalCenter
                            text:paypal
                            onTextChanged: paypal = text, Scripts.artuserdb("save");
                        }
                    }

                    Text {
                        text:i18n.tr("Patreon: ")
                        color:"white"
                        font.pixelSize: settingscolumn.height * 0.025
                        TextField {
                            anchors.left:parent.right
                            width:(comoptscolumn.width - parent.width) * 0.96
                            anchors.verticalCenter: parent.verticalCenter
                            text:patreon
                            onTextChanged: patreon = text, Scripts.artuserdb("save");
                        }
                    }

                    Text {
                        text:i18n.tr("CoinBase: ")
                        color:"white"
                        font.pixelSize: settingscolumn.height * 0.025
                        TextField {
                            anchors.left:parent.right
                            width:(comoptscolumn.width - parent.width) * 0.96
                            anchors.verticalCenter: parent.verticalCenter
                            text:coinbase
                            onTextChanged: coinbase = text, Scripts.artuserdb("save");
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
