import QtQuick 2.4
import Ubuntu.Components 1.3

Item {
    clip:true

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
                //anchors.centerIn:parent
                source:"graphics/newImageAdd.png"
                //anchors.fill:parent
                width:parent.width
                height:parent.height * 0.90
                fillMode:Image.PreserveAspectFit
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

                onClicked:newArt.state = "Show"
            }
            }


    model: ListModel {
            id: imagelist

            ListElement {
                name:"AddNew"
                img:"graphics/newImageAdd.png"
            }

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

}
