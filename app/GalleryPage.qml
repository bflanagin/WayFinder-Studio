import QtQuick 2.4
import Ubuntu.Components 1.3

import QtQuick.LocalStorage 2.0 as Sql

import "Main.js" as Scripts
import "openseed.js" as OpenSeed

Item {
    clip:true

    visible:false

    onVisibleChanged: if(visible == true) {Scripts.load_gallery()}



GridView {
    id:grid
    width:parent.width * 0.95
    height:parent.height * 0.95
    anchors.centerIn: parent
    cellHeight: parent.height * 0.45
    cellWidth: parent.width * 0.20
    //cellHeight:80
    //cellWidth:80




    delegate:
        Item {
            width:grid.cellWidth * 0.90
            height:grid.cellHeight * 0.90
            clip:true
            Image {

                source:img

                width:parent.width
                height:parent.height * 0.90
                fillMode:if(img =="graphics/newImageAdd.png") {Image.PreserveAspectfit} else {Image.PreserveAspectCrop}
                Text {
                 text:name
                 anchors.top:parent.bottom
                 anchors.horizontalCenter: parent.horizontalCenter
                 anchors.topMargin:10
                 color:"white"
                }
                }

            MouseArea {
                anchors.fill:parent
                onEntered:footer.state = "show"
                onExited: footer.state = "hide"
                hoverEnabled : true

                onClicked:if(name == "AddNew") {newArt.state = "Show"} else {
                                race = trace,
                                aclass= tclass,
                                artdiscription=tdiscription,
                                download=tdownload,
                                cost=tcost,
                                base=tbase,
                                artname=name,
                                        editArt.type = type,
                                       editArt.preview = img,
                                      editArt.title = name,
                                      editArt.state = "Show"}
            }
            }


    model: ListModel {
            id: imagelist

    }




}

Footer {
    id:footer
    width:parent.width
    height:parent.height * 0.10
    state:"hide"

}

NewArt {
    id:newArt
    anchors.centerIn: parent
    width:parent.width * 0.60
    height:parent.height * 0.60
    state:"Hide"
}

EditArt {
    id:editArt
    anchors.centerIn: parent
    width:parent.width * 0.80
    height:parent.height * 0.90
    state:"Hide"

}

}
