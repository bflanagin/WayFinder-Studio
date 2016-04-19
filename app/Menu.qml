import QtQuick 2.4
import Ubuntu.Components 1.3

Item {


    Rectangle {
        anchors.fill:parent
        color:UbuntuColors.warmGrey
        border.color:UbuntuColors.graphite

    }

    Column {
        anchors.top:parent.top
        anchors.topMargin:10
        anchors.fill:parent
        spacing: 4

        WFButton {
            id:art
            width:parent.width -1
            height:parent.height / 15
            title:i18n.tr("Art")
            state:"Unselected"

            MouseArea {
                anchors.fill:parent
                onClicked:if(art.state == "Selected") {clearall();art.state = "Unselected",artPages.state = "Hide"} else {clearall();art.state = "Selected",artPages.state = "Show"}
            }
        }

        WFButton {
            id:story
            width:parent.width -1
            height:parent.height / 15
            title:i18n.tr("Adventure")
            state:"Unselected"
            MouseArea {
                anchors.fill:parent
                onClicked:if(story.state == "Selected") {clearall();story.state = "Unselected",storyPages.state = "Hide"} else {clearall();story.state = "Selected",storyPages.state = "Show"}
            }
        }

            WFButton {
                id:cust
                width:parent.width -1
                height:parent.height / 15
                title:i18n.tr("Custom")
                state:"Unselected"
                MouseArea {
                    anchors.fill:parent
                    onClicked:if(cust.state == "Selected") {cust.state = "Unselected"} else {cust.state = "Selected"}
                }
            }


    }


    function clearall() {
            art.state = "Unselected";
            artPages.state = "Hide";
            story.state = "Unselected";
            storyPages.state = "Hide"

    }

}
