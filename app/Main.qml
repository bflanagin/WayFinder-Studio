import QtQuick 2.4
import Ubuntu.Components 1.3

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

    property string username: ""
    property string useremail: ""
    property string id: ""


    property string artistname: ""
    property string storename: ""
    property string discription: ""
    property string contact: ""
    property int commissions: 0
    property int pub: 0
    property int donations: 0

    property string paypal: ""
    property string patreon: ""
    property string coinbase: ""





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
            z:if(selectedtab == 2) {2} else {0}

            GalleryPage {
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


    }
}

