import QtQuick 2.4
import Ubuntu.Components 1.3
import WayFinder 1.0

import QtQuick.LocalStorage 2.0 as Sql

import "Main.js" as Scripts
import "openseed.js" as OpenSeed

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    id:mainWindow

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "wayfinder-studio.vagueentertainment"

    width: units.gu(300)
    height: units.gu(175)

    property int selectedtab: 1
    property string devId: "Vag-01001011"
    property string appId: "VagRpg-45454"


    property date currentdate: new Date()
    property string thedate: currentdate.getDay()+"-"+currentdate.getMonth()+"-"+currentdate.getFullYear()

    property string username: " "
    property string useremail: " "
    property string id: " "


    property string artistname: " "
    property string storename: " "
    property string discription: " "
    property string contact: ""
    property int commissions: 0
    property int pub: 0
    property int donations: 0

    property string paypal: " "
    property string patreon: ""
    property string coinbase: " "

    property string avatarimg: " "
    property string sampleimg: " "


    property string race: " "
    property string aclass: " "

    property string cost: "0.00"
    property int download: 1
    property int base: 0

    property string artdiscription: " "
    property string artname: " "
    property string heart: "Offline"
    property int updateinterval: 2000
    property int changes: 0

    property string imagedata: " "


    //story variables //

    property string story_title: " "
    property string author: " "
    property string story_summary: " "
    property string story_contact: " "
    property string story: " "
    property string characters: " "
    property int story_pub: 0
    property int story_donations: 0
    property string story_paypal: " "
    property string story_patreon: " "
    property string story_coinbase: " "

    property string cover: " "
    property string coverdata: " "
    property string pub_date: " "
    property string storyid: " "
    property string storysearch: " "


    //map variables//


    property int mapcreated: 0 //terrain map
    property int enmapcreated: 0 //enemy map
    property int exmapcreated: 0 //exit map
    property int imapcreated: 0 //item map

    property int currentlayer: 0


    property int quickfill: 0

    property int current_cw: 0
    property int current_cf: 0
    property int current_base: 0

    property string maptitle: " "
    property string mapdiscription: " "
    property string mapid: " "

    //Codex info ///

    property int clvl: 1




    Timer {
        id:initialbeat
        interval:20
        running:true
        repeat:false
        onTriggered: OpenSeed.heartbeat()
    }


    Timer {
        id:heartbeats
        //interval:30000
        running:true
        repeat:true
        onTriggered: { if(heart == "Online" && changes == 1) {
                        //OpenSeed.send_info();
            }
                 OpenSeed.heartbeat()
        }
    }


MyIOout {
    id:fileio

        Component.onCompleted: {
         fileio.create = "makestuff"

            console.log(fileio.create)

        }

}


    Timer {
        id:startup
        running:true
        repeat:false
        interval: 10
        onTriggered: Scripts.loaddb()
    }

    Page {
        header: PageHeader {
            id: pageHeader
            title: i18n.tr("WayFinder-Studio")
            StyleHints {
                foregroundColor: UbuntuColors.orange
                backgroundColor: UbuntuColors.slate
                dividerColor: UbuntuColors.darkAubergine
            }
        }

        Rectangle {
            anchors.fill:parent
            color:UbuntuColors.ash
        }
        Item {
            width:parent.width * 0.85
            anchors.right:parent.right
            height:parent.height - pageHeader.height
            y:pageHeader.height

        Image {
            anchors.fill:parent
            source:"graphics/wayfinder-big.png"
            fillMode:Image.PreserveAspectFit
            opacity:0.40
        }

        Rectangle {
            id:codex
            width:parent.width * 0.05
            height:parent.width * 0.05
            radius:width / 2
            anchors.top:parent.top
            anchors.right:parent.right
            anchors.margins: parent.width * 0.02
            border.color:"gray"
            color:UbuntuColors.coolGrey

            Image {
               source:"/usr/share/icons/suru/actions/scalable/bookmark.svg"
               anchors.centerIn:parent
               width:parent.width * 0.5
               height:parent.width * 0.5

            }

            MouseArea {
                anchors.fill:parent
               // onClicked:OpenSeed.codex("armor"),OpenSeed.codex("equip")
                hoverEnabled: true
                onEntered:codex.color = "darkGray"
                onExited: codex.color = UbuntuColors.coolGrey

            }



            Row {
                id:codextype
                anchors.right:parent.left

                spacing: 5
                width: parent.width * 5.4
                height:parent.height
                clip:true

                Rectangle {
                    //id:codex
                    width:codex.width
                    height:codex.width
                    radius:width / 2
                     clip:true

                    border.color:"gray"
                    color:UbuntuColors.coolGrey

                    Image {
                        anchors.centerIn: parent
                        width:parent.width * 0.70
                        height:parent.width * 0.70
                        source:"graphics/map/armor.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    MouseArea {
                        anchors.fill:parent
                        onClicked:Scripts.codex("armor"),the_codex.state = "Show"
                        hoverEnabled: true
                        onEntered:parent.color = "darkGray"
                        onExited: parent.color = UbuntuColors.coolGrey

                    }
                }
                Rectangle {
                    //id:codex
                    width:codex.width
                    height:codex.width
                    radius:width / 2
                     clip:true

                    border.color:"gray"
                    color:UbuntuColors.coolGrey


                    Image {
                        anchors.centerIn: parent
                        width:parent.width * 0.70
                        height:parent.width * 0.70
                        source:"graphics/map/weapons.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    MouseArea {
                        anchors.fill:parent
                        onClicked:Scripts.codex("weapons"),the_codex.state = "Show"
                        hoverEnabled: true
                        onEntered:parent.color = "darkGray"
                        onExited: parent.color = UbuntuColors.coolGrey

                    }
                }
                Rectangle {
                    //id:codex
                    width:codex.width
                    height:codex.width
                    radius:width / 2
                    clip:true

                    border.color:"gray"
                    color:UbuntuColors.coolGrey

                    Image {
                        anchors.centerIn: parent
                        width:parent.width * 0.60
                        height:parent.width * 0.60
                        source:"graphics/map/enemy.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    MouseArea {
                        anchors.fill:parent
                        onClicked:Scripts.codex("enemy"),the_codex.state = "Show"
                        hoverEnabled: true
                        onEntered:parent.color = "darkGray"
                        onExited: parent.color = UbuntuColors.coolGrey

                    }

                }
                Rectangle {
                    //id:codex
                    width:codex.width
                    height:codex.width
                    radius:width / 2
                     clip:true

                    border.color:"gray"
                    color:UbuntuColors.coolGrey

                    Image {
                        anchors.centerIn: parent
                        width:parent.width * 0.60
                        height:parent.width * 0.60
                        source:"graphics/map/items.png"
                        fillMode: Image.PreserveAspectFit
                    }

                }
                Rectangle {
                    //id:codex
                    width:codex.width
                    height:codex.width
                    radius:width / 2
                     clip:true

                    border.color:"gray"
                    color:UbuntuColors.coolGrey

                    Image {
                        anchors.centerIn: parent
                        width:parent.width * 0.80
                        height:parent.width * 0.80
                        source:"graphics/map/magic.png"
                        fillMode: Image.PreserveAspectFit
                    }

                }



            }

            Column {
                anchors.top:parent.bottom
                width:parent.width
                anchors.topMargin:10
                height:parent.height * 4
                spacing: 5
                clip:true

                Rectangle {
                    id:reload
                    width:codex.width
                    height:codex.width
                    radius:width / 2

                    border.color:"gray"
                    color:UbuntuColors.coolGrey

                    Image {
                        anchors.centerIn: parent
                        width:parent.width * 0.70
                        height:parent.width * 0.70
                        source:"/usr/share/icons/suru/actions/scalable/reload.svg"
                        fillMode: Image.PreserveAspectFit
                    }

                     MouseArea {
                         anchors.fill:parent
                         onClicked:OpenSeed.codex("armor"),OpenSeed.codex("equip")
                         hoverEnabled: true
                        onEntered:reload.color = "darkGray"
                         onExited: reload.color = UbuntuColors.coolGrey
                     }

                }
                Rectangle {
                    //id:codex
                    width:codex.width
                    height:codex.width
                    radius:width / 2

                    border.color:"gray"
                    color:UbuntuColors.coolGrey

                    Image {
                        anchors.centerIn: parent
                        width:parent.width * 0.70
                        height:parent.width * 0.70
                        source:"/usr/share/icons/suru/actions/scalable/inbox.svg"
                        fillMode: Image.PreserveAspectFit
                    }
                }
                Rectangle {
                    //id:codex
                    width:codex.width
                    height:codex.width
                    radius:width / 2

                    border.color:"gray"
                    color:UbuntuColors.coolGrey

                    Image {
                        anchors.centerIn: parent
                        width:parent.width * 0.70
                        height:parent.width * 0.70
                        source:"/usr/share/icons/suru/actions/scalable/starred.svg"
                        fillMode: Image.PreserveAspectFit
                    }
                }


            }



        }

        Item {
            id:artPages
                width:parent.width
                height:parent.height
                //visible:false

                states: [
                    State {
                        name:"Show"
                        PropertyChanges {
                            target:artPages
                            x:0

                        }
                    },
                    State {
                        name:"Hide"
                        PropertyChanges {
                            target:artPages
                            x:parent.width

                        }
                    }

                ]

                transitions: [
                    Transition {
                        from: "Hide"
                        to: "Show"


                        NumberAnimation {
                            target: artPages
                            property: "x"
                            duration: 600
                            easing.type: Easing.InOutQuad
                        }
                    },

                    Transition {
                        from: "Show"
                        to: "Hide"


                        NumberAnimation {
                            target: artPages
                            property: "x"
                            duration: 600
                            easing.type: Easing.InOutQuad
                        }
                    }

                ]

                onStateChanged: if(artPages.state == "Show") {Scripts.artuserdb("load")}

                state:"Hide"

        Pages {
            id:store
            width:parent.width * 0.95
            height:parent.height * 0.94
            anchors.centerIn: parent
            title:"Store"
            state:"pos1"

            tab:1
            z:if(selectedtab == 1) {2} else {0}


            StorePage {
                width:parent.width * 0.99
                height:parent.height * 0.95
                anchors.centerIn: parent
            }

        }
        Pages {
            id:gallery
            width:parent.width * 0.95
            height:parent.height * 0.94
            anchors.centerIn: parent
            title:"Gallery"
            state:"pos2"
            tab:2
            z:if(selectedtab == 2) {2,gp.visible = true} else {0}

            GalleryPage {
                id:gp
                width:parent.width * 0.99
                height:parent.height * 0.95
                anchors.centerIn: parent

            }
        }
        Pages {
            id:commission
            width:parent.width * 0.95
            height:parent.height * 0.94
            anchors.centerIn: parent
            title:"Comissions"
            state:"pos3"
            tab:3
            z:if(selectedtab == 3) {2} else {0}

            CommissionsPage {
                width:parent.width * 0.99
                height:parent.height * 0.95
                anchors.centerIn: parent
            }
        }

        }


        Item {
            id:storyPages
                width:parent.width
                height:parent.height
                //visible:false

                states: [
                    State {
                        name:"Show"
                        PropertyChanges {
                            target:storyPages
                            x:0

                        }
                    },
                    State {
                        name:"Hide"
                        PropertyChanges {
                            target:storyPages
                            x:parent.width

                        }
                    }

                ]

                transitions: [
                    Transition {
                        from: "Hide"
                        to: "Show"


                        NumberAnimation {
                            target: storyPages
                            property: "x"
                            duration: 600
                            easing.type: Easing.InOutQuad
                        }
                    },

                    Transition {
                        from: "Show"
                        to: "Hide"


                        NumberAnimation {
                            target: storyPages
                            property: "x"
                            duration: 600
                            easing.type: Easing.InOutQuad
                        }
                    }

                ]



                state:"Hide"

        Pages {
            id:storySetup
            width:parent.width * 0.95
            height:parent.height * 0.94
            anchors.centerIn: parent
            title:"Story"
            state:"pos1"

            tab:1
            z:if(selectedtab == 1) {2} else {0}

            StoryPage {
                width:parent.width * 0.99
                height:parent.height * 0.95
                anchors.centerIn: parent
            }

        }
        Pages {
            id:storyMap
            width:parent.width * 0.95
            height:parent.height * 0.94
            anchors.centerIn: parent
            title:"Maps"
            state:"pos2"
            tab:2
            z:if(selectedtab == 2) {2} else {0}

            MapPage {
                z:if(selectedtab == 2) {1} else {0}
                width:parent.width * 0.99
                height:parent.height * 0.95
                anchors.centerIn: parent
            }
        }


        }






        }

        Menu {
            id:themenu
            anchors.top:pageHeader.bottom
            width:parent.width * 0.15
            anchors.left:parent.left
            height:parent.height - pageHeader.height
        }


        Auth {
            id:os_connect
            x:parent.width / 3
            y:parent.height /5
            width:parent.width * 0.40
            height:parent.width * 0.30

        }

        Codex {
            id:the_codex
            //anchors.horizontalCenter: parent.horizontalCenter
            x:themenu.width + parent.width * 0.04
            y:parent.height * 0.10
            width:parent.width * 0.70
            height: parent.height * 0.80
            state: "Hide"
            dbsource: "none"


        }


    }
}

