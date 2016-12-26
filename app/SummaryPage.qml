import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.1
import "Main.js" as Scripts

import QtQuick.LocalStorage 2.0 as Sql

Item {
    id:window_container

    clip:true

    onZChanged: if(window_container.z == 1){Scripts.build_summary()}



   Flickable {
       anchors.top:parent.top
       anchors.left:parent.left
       anchors.margins: parent.height * 0.02

       width:parent.width * 0.98
       height:parent.height * 0.95

      //contentHeight: summarycolumn.height
       contentWidth:parent.width * 0.98


       ListView {
           width:parent.width
           height:parent.height

           id:summarycolumn




           model: ListModel {
               id:summary



           }

           delegate: Item {
                width:parent.width
                height:discriptionblock.height * 1.12

                Rectangle {
                    color:"white"
                    radius:8
                    anchors.centerIn: discriptionblock
                    width:discriptionblock.width * 1.04
                    height:discriptionblock.height * 1.04
                }

                Item {
                    id:discriptionblock

                    anchors.left: if(LoR % 2 == 0){parent.left} else {summaryimg.right}
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.02
                    anchors.leftMargin:if(LoR % 2 == 0) {parent.width * 0.01} else {parent.width * 0.08}
                    width:parent.width * 0.60
                    height:summaryimg.height


                    Column {

                        width:parent.width
                        //height:parent.height
                        spacing:4

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text:title
                        font.pixelSize: parent.width * 0.05
                    }
                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width:parent.width * 0.98
                        height:4
                        color:"gray"
                    }

                    Text {

                        text:textblock
                        wrapMode: Text.WordWrap
                        width:parent.width
                        font.pixelSize: parent.width * 0.025
                    }


                    }
                }

                Image {
                    id:summaryimg
                    anchors.left: if(LoR % 2 == 0){discriptionblock.right} else {parent.left}
                   // anchors.top: parent.top
                    anchors.leftMargin: parent.width * 0.08
                    source:"graphics/story_template.svg"
                    width:parent.width * 0.20
                    fillMode:Image.PreserveAspectFit
                    anchors.verticalCenter: discriptionblock.verticalCenter

                }


           }


       }


}









//nothing below this point
}
