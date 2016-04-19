import QtQuick 2.4
import Ubuntu.Components 1.3

Item {
    id:button
    property string title: ""

    states: [

        State {
               name:"Selected"
                PropertyChanges {
                    target:bg
                    color:UbuntuColors.orange
                }
                PropertyChanges {
                    target:pointer
                    color:UbuntuColors.orange
                    x:bg.width * 0.92

                }
                PropertyChanges {
                    target:text
                    color:UbuntuColors.porcelain
                }
            },

        State {
            name:"Unselected"

            PropertyChanges {
                target:bg
                color:UbuntuColors.silk
            }
            PropertyChanges {
                target:pointer
                color:UbuntuColors.silk
                x:bg.width * 0.80
            }
            PropertyChanges {
                target:text
                color:UbuntuColors.inkstone
            }

        }


    ]

    transitions: [
        Transition {
            from: "Unselected"
            to: "Selected"

            NumberAnimation {
                target: pointer
                property: "x,color"
                duration: 80
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: bg
                property: "color"
                duration: 80
                easing.type: Easing.InOutQuad
            }
        }

    ]


    Rectangle {
        id:pointer
        color:UbuntuColors.silk
        //anchors.left:bg.right
        //anchors.leftMargin: width / -2
        x:bg.width * 0.80

        //border.color:"gray"
        rotation: 45
        anchors.verticalCenter: bg.verticalCenter
        width:bg.height * 0.70
        height:bg.height * 0.70
    }

    Rectangle {
        id:bg
        color:UbuntuColors.silk
        anchors.fill:parent
        //border.color:"gray"
    }
    Text {
        id:text
        color:UbuntuColors.inkstone
        anchors.centerIn: parent
        text:title
        font.pixelSize: parent.height / 2
    }


}
