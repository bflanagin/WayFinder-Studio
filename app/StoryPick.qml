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

    state:"Hide"

   onStateChanged: if(window_container.state == "Show") {Scripts.list_stories()}

Rectangle {
    id:window
    z:0
    width:parent.width * 0.99
    anchors.centerIn: parent
    height:parent.height * 0.95
    radius:8
    color:UbuntuColors.coolGrey
    border.color:UbuntuColors.warmGrey


    TextField {
        id:search
        anchors.top:parent.top
        anchors.right:parent.right
        anchors.margins: 10
        text:storysearch


    Text {
        text:i18n.tr("Search: ")
        anchors.right:parent.left
        color:"white"
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: parent.height * 0.80

    }

    }



Rectangle {
    id:tag
    z:1
    width:window.width * 0.10
    height:parent.height * 0.06
    x:window.x
    y:window.y * -1.7
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

GridView {
    id:grid
    width:parent.width * 0.95
    height:parent.height * 0.90
    anchors.bottom:parent.bottom
    cellHeight: parent.height * 0.95
    cellWidth: parent.width * 0.30
    flow: GridView.FlowTopToBottom
    //cellHeight:80
    //cellWidth:80
    clip:true




    delegate:
        Item {
            width:grid.cellWidth * 0.94
            height:grid.cellHeight * 0.94
            clip:true
            Image {

                source:img

                width:parent.width
                height:parent.height * 0.90
                fillMode:if(img =="graphics/newImageAdd.png") {Image.PreserveAspectfit} else {Image.PreserveAspectfit}
                Text {
                 text:name
                 anchors.top:parent.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 anchors.topMargin:10
                 width:parent.width * 0.99
                 wrapMode:Text.WordWrap
                 horizontalAlignment: Text.AlignHCenter
                 font.pixelSize: parent.width * 0.07
                 color:"white"
                }
                }

            MouseArea {
                anchors.fill:parent
                hoverEnabled : true

                onClicked: {if(stories == "noid") {window_container.state = "Hide",leftside.state = "Show",rightside.state = "Show", storyid = "noid"} else {
                              window_container.state = "Hide",
                                      leftside.state = "Show",
                                      rightside.state = "Show",
                                      author = theauthor,
                                      story_title = name,
                                      story_summary = thesummary,
                                      story = thestory,
                                      story_contact = thecontact,
                                      characters = thecharacters,
                                      story_pub = thepublished,
                                      story_donations = thedonations,
                                      story_paypal = thepaypal,
                                      story_patreon = thepatreon,
                                      story_coinbase = thecoinbase,
                                      pub_date = thecreationdate,
                                      cover = thecover,
                                      storyid = thestoryid


                          }
                            console.log("from story pick "+storyid);


                }
            }
            }


    model: ListModel {
            id: storylist


    }




}





}


}
