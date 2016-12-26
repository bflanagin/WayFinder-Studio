import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Dialogs 1.0

import QtQuick.LocalStorage 2.0 as Sql

import "Main.js" as Scripts



Item {
    clip:true
    id:storypage


    Timer {
        id:autosave
        interval:2000
        running:false
        onTriggered: Scripts.save_story();
    }



    Item {
        id:leftside
        height:parent.height
        width: parent.width

        states: [

            State {
                name: "Hide"
                PropertyChanges {
                    target: leftside
                    x:-parent.width * 0.60
                }
            },

            State {
                name: "Show"
                PropertyChanges {
                    target: leftside
                    x:0

                }
            }

        ]

        state:"Hide"

    onStateChanged: if(leftside.state == "Show") {autosave.running = true} else {autosave.running = false}


    Text {
        anchors.top:parent.top
        anchors.topMargin:10
        x:10
        id:title
        text:i18n.tr("Setup:")
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
                text:i18n.tr("Title: ")
                color:"white"
                font.pixelSize: parent.height * 0.02
                TextField {
                    anchors.left:parent.right
                    width:(settingscolumn.width - parent.width) * 0.96
                    anchors.verticalCenter: parent.verticalCenter
                    text:story_title
                    onTextChanged: story_title = text

                }
            }

            Text {
                text:i18n.tr("Author: ")
                color:"white"
                font.pixelSize: parent.height * 0.02
                TextField {
                    anchors.left:parent.right
                    width:(settingscolumn.width - parent.width) * 0.96
                    anchors.verticalCenter: parent.verticalCenter
                    text:author
                    onTextChanged: author = text

                }
            }
            Row {
                id:row1
                width:parent.width
                spacing:parent.width * 0.20

            Text {
                text:i18n.tr("Date: ")
                color:"white"
                font.pixelSize: settingscolumn.height * 0.02
                TextField {
                    id:date
                    anchors.left:parent.right
                    width:(row1.width - parent.width) * 0.20
                   anchors.verticalCenter: parent.verticalCenter
                   text:thedate
                   onTextChanged: pub_date = text

                }
            }

            Text {
                text:i18n.tr("Contact Info: ")
                color:"white"
                font.pixelSize: settingscolumn.height * 0.02
                TextField {
                    anchors.left:parent.right
                    width:(row1.width - parent.width) * 0.62
                    anchors.verticalCenter: parent.verticalCenter
                    text:story_contact
                    onTextChanged: story_contact = text


                }
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
                    text:i18n.tr("Publish: ")
                    font.pixelSize: parent.width * 0.03
                    color:"white"

                    CheckBox {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left:parent.right
                        id:pub
                        checked:if(story_pub == 1) {true} else {false}
                        onCheckedChanged: story_pub = checked,Scripts.save_story()

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
                    checked:if(story_donations == 1) {true} else {false}
                    onCheckedChanged: story_donations = checked,Scripts.save_story()

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
                    height:comoptscolumn.height + comoptscolumn.y
                    visible: if(donations.checked == 1 ) {true} else {false}


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
                    //height:coinbase.height+ coinbase.y


                    Text {
                        text:i18n.tr("Pay Pal: ")
                        color:"white"
                        font.pixelSize: settingscolumn.height * 0.025
                        TextField {
                            id:paypal
                            anchors.left:parent.right
                            width:(comoptscolumn.width - parent.width) * 0.96
                            anchors.verticalCenter: parent.verticalCenter
                            text:story_paypal
                            onTextChanged: story_paypal = text

                        }
                    }

                    Text {
                        text:i18n.tr("Patreon: ")
                        color:"white"
                        font.pixelSize: settingscolumn.height * 0.025
                        TextField {
                            id:patreon
                            anchors.left:parent.right
                            width:(comoptscolumn.width - parent.width) * 0.96
                            anchors.verticalCenter: parent.verticalCenter
                            text:story_patreon
                            onTextChanged: story_patreon = text
                        }
                    }

                    Text {
                        text:i18n.tr("CoinBase: ")
                        color:"white"
                        font.pixelSize: settingscolumn.height * 0.025
                        TextField {
                            id:coinbase
                            anchors.left:parent.right
                            width:(comoptscolumn.width - parent.width) * 0.96
                            anchors.verticalCenter: parent.verticalCenter
                            text:story_coinbase
                            onTextChanged: story_coinbase = text
                        }
                    }



                }



        }

            }

            Rectangle {
                visible: if(donations.checked == 1 ) {true} else {false}
                width:parent.width * 0.96
                height: 3
                color:UbuntuColors.darkAubergine
            }

            Image {
                id:sample
                anchors.horizontalCenter: settingscolumn.horizontalCenter
                width:(settingscolumn.width - x) * 0.70
                height:(settingscolumn.height - y) * 0.85
                source:"graphics/newImageAdd.png"
                fillMode:Image.PreserveAspectFit

            }

            Text {
                anchors.horizontalCenter:settingscolumn.horizontalCenter


                text:i18n.tr("Cover Art")
                color:"white"
                font.pixelSize: parent.width * 0.03
            }


        }

    }

    }


    Item {
        id:rightside
        height:parent.height
        width: parent.width

        states: [

            State {
                name: "Hide"
                PropertyChanges {
                    target: rightside
                    x:parent.width * 0.60

                }
            },

            State {
                name: "Show"
                PropertyChanges {
                    target: rightside
                    x:0

                }
            }

        ]

        state:"Hide"

    Text {
        id:about
        anchors.top:parent.top
        anchors.topMargin:10
        anchors.left:storybg.left
        text:i18n.tr("About:")
        color:"white"
        font.pixelSize: parent.height * 0.03
    }

    Rectangle {
        id:storybg
        anchors.top:about.bottom
        anchors.topMargin:10
        anchors.right:parent.right
        anchors.rightMargin:10
        width:parent.width * 0.55
        height:(parent.height - title.height) * 0.95
        radius:8
        border.color:UbuntuColors.darkAubergine
        color:UbuntuColors.ash

        Column {
            id:storycolumn
            anchors.left:parent.left
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.96
            height: parent.height
            clip:true
            spacing:10

            Item {
                width:storycolumn.width
                height:summary.height+summary.y

            Text {
                text:i18n.tr("Pitch:")
                color:"white"
                x:storycolumn.width * 0.01
                font.pixelSize: storycolumn.height * 0.03
                TextArea {
                    id:summary
                    anchors.top:parent.bottom

                    width:storycolumn.width * 0.98
                    height:storycolumn.height / 3
                    text:story_summary
                    onTextChanged: story_summary = text
                    onFocusChanged: Scripts.save_story()
                }
            }

            }


            Item {
                width:storycolumn.width
                height:storySoFar.height +storySoFar.y

            Text {
                text:i18n.tr("Story so far:")
                color:"white"
                x:storycolumn.width * 0.01
                font.pixelSize: storycolumn.height * 0.03
                TextArea {
                    id:storySoFar
                    anchors.top:parent.bottom

                    width:storycolumn.width * 0.98
                    height:storycolumn.height / 1.75
                    text:story
                    onTextChanged: story = text
                     onFocusChanged: Scripts.save_story()
                }
            }

            }

        }


}

    }

   StoryPick {
    anchors.centerIn: parent
    width:parent.width * 0.70
    height:parent.height * 0.60
    state:"Show"

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
