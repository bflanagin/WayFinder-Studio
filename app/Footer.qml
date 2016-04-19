import QtQuick 2.4
import Ubuntu.Components 1.3


Item {
    id:popup

    property int views: 0
    property int likes: 0
    property int downloads: 0
    property int commissions: 0

    states: [
            State {
                name:"show"
                PropertyChanges {
                    target:popup
                    y:parent.height - height
                }
        },
        State {
            name:"hide"
            PropertyChanges {
                target:popup
                y:parent.height
            }
        }

    ]

    state:hide

    Rectangle {
        id:bg
        anchors.fill: parent
        color:UbuntuColors.ash
        opacity: 0.20
        radius:8
    }

    Text {
        id:viewstext
        text:i18n.tr("Views: ")+views
        color:"white"
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.margins: 10
    }
    Text {
        id:likestext
        anchors.top:viewstext.bottom
        text:i18n.tr("Likes: ")+likes
        color:"white"
        anchors.left:parent.left
        anchors.margins: 10
    }

    Text {
        id:downloadstext
        text:i18n.tr("Downloads: ")+downloads
        color:"white"
        anchors.top:parent.top
        anchors.right:parent.right
        anchors.margins: 10
    }
    Text {
        id:commissionstext
        anchors.top:viewstext.bottom
        text:i18n.tr("Commissions: ")+commissions
        color:"white"
        anchors.right:parent.right
        anchors.margins: 10
    }




}
