import QtQuick 2.4
import Ubuntu.Components 1.3

Item {

    Text {
        anchors.top:parent.top
        anchors.topMargin:10
        x:10
        id:title
        text:i18n.tr("Current Commissions:")
        color:"white"
        font.pixelSize: parent.height * 0.03
    }

    GridView{
        id:currentgrid
        anchors.top:title.bottom
        anchors.topMargin:40
        width:parent.width * 0.85
        height:parent.height * 0.70
        cellHeight: parent.height * 0.60
        cellWidth: parent.width * 0.30
        flow: GridView.FlowTopToBottom
        clip:true

        delegate:
            Item {
                width:currentgrid.cellWidth * 0.96
                height:currentgrid.cellHeight * 0.98
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
                }


        model: ListModel {
                id: currentlist

                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }

                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }



        }

    }

    Text {
        anchors.top:currentgrid.bottom
        //anchors.topMargin:10
        x:10
        id:complete
        text:i18n.tr("Completed:")
        color:"white"
        font.pixelSize: parent.height * 0.03
    }

    GridView{
        id:completegrid
        anchors.top:complete.bottom
        anchors.topMargin:10
        width:parent.width * 0.85
        height:parent.height * 0.20
        cellHeight: height * 0.90
        cellWidth: width * 0.10
        flow: GridView.FlowTopToBottom

        clip:true

        delegate:
            Item {
                width:completegrid.cellWidth * 0.90
                height:completegrid.cellHeight * 0.80
                clip:true
                Image {
                    //anchors.centerIn:parent
                    source:"graphics/newImageAdd.png"
                    //anchors.fill:parent
                    width:parent.width
                    height:parent.height * 0.75
                    fillMode:Image.PreserveAspectFit
                    Text {
                     text:name
                     anchors.top:parent.bottom
                     anchors.horizontalCenter: parent.horizontalCenter
                     anchors.topMargin:10
                     color:"white"
                    }
                    }


                }


        model: ListModel {
                id: completelist

                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
        }

    }

    Text {
        anchors.top:parent.top
        anchors.topMargin:10
        anchors.left:currentgrid.right

        x:10
        id:review
        text:i18n.tr("  Review:")
        color:"white"
        font.pixelSize: parent.height * 0.03
    }

    GridView{
        id:reviewgrid
        anchors.top:review.bottom
        anchors.topMargin:10
        anchors.left:review.left
        anchors.leftMargin:10
        width:parent.width * 0.15
        height:parent.height
        cellHeight: height * 0.50
        cellWidth: width * 0.90
        flow: GridView.FlowLeftToRight

        clip:true

        delegate:
            Item {
                width:reviewgrid.cellWidth * 0.90
                height:reviewgrid.cellHeight * 0.90
                clip:true
                Image {
                    //anchors.centerIn:parent
                    source:"graphics/newImageAdd.png"
                    //anchors.fill:parent
                    width:parent.width
                    height:parent.height * 0.75
                    fillMode:Image.PreserveAspectFit
                    Text {
                     text:name
                     anchors.top:parent.bottom
                     anchors.horizontalCenter: parent.horizontalCenter
                     anchors.topMargin:10
                     color:"white"
                    }
                    }


                }


        model: ListModel {
                id: reviewlist

                ListElement {
                    name:"AddNew"
                    img:"graphics/newImageAdd.png"
                }
        }

    }




}
