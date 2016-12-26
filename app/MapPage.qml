import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.1
import "Main.js" as Scripts

import QtQuick.LocalStorage 2.0 as Sql

Item {
    id:window_container
    property string areaname: "No Name"
    property int zoomlevel: 1
    property string discription: ""

    clip:true

    onZChanged: if(window_container.z == 1){Scripts.mapgrid(),Scripts.enemygrid(),Scripts.itemgrid(),Scripts.load_map(storyid+"_01")} else {}



    Timer {
        id:autowaller
        running:false
        repeat:true
        interval:1000
        onTriggered:Scripts.autowall()

    }

    Timer {
        id:autosave
        running:false
        repeat:true
        interval:5000
        onTriggered:Scripts.save_map()

    }

    Timer {
        id:monstersize
        running:false
        repeat:true
        interval:1
        onTriggered:Scripts.monsterSize(enemy_size,current_highlight);
    }

    Rectangle {
        color:UbuntuColors.warmGrey
        anchors.fill:mapflick
        anchors.margins: -10
        radius:8
    }
    Flickable {
            id:mapflick
        width:parent.width * 0.80
        height:parent.height * 0.95
        anchors.left:parent.left
        anchors.leftMargin:20
        anchors.verticalCenter: parent.verticalCenter
        contentHeight: maparea.height * 1.2
        contentWidth:maparea.width
        clip:true
        //interactive:false

        Item {
            id:maparea
            width:parent.width * zoomlevel
            height:parent.width * zoomlevel
            visible: true

        }

       Item {
            id:enmaparea
            width:parent.width * zoomlevel
            height:parent.width * zoomlevel
            visible: true

        }

      /*  Item {
            id:exmaparea
            width:parent.width * zoomlevel
            height:parent.width * zoomlevel
            visible: false
        }

        Item {
            id:imaparea
            width:parent.width * zoomlevel
            height:parent.width * zoomlevel
            visible: false
        }
        */



    }

    Item {
        anchors.bottom:parent.bottom
        anchors.margins:20
        anchors.left: parent.left
        height:parent.height * 0.10
        width:parent.width * 0.20

        Rectangle {
            color:UbuntuColors.coolGrey
            border.color:Qt.rgba(0.5,0.5,0.5,0.5)
            border.width:4
            anchors.fill:parent
        }

    Text {
        anchors.top:parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        id:title
        text:i18n.tr("Map - "+maptitle)
        color:"white"
        font.pixelSize: parent.height * 0.2
    }

    Rectangle {
        color:{
            switch(current_base) {
            case 1: "#034405";break;
            case 2: Qt.rgba(0.5,0.3,0.1,1);break;
            case 3:"#ACA069";break;
            case 4:"#86c6fd";break;
            case 5:"#d4d8dc";break;
            default:"white";break;
        }
        }
        anchors.left:parent.left
        anchors.leftMargin:10
        anchors.verticalCenter: parent.verticalCenter
        width:parent.width * .15
        height:parent.width * .15
        border.color:"grey"

        Text {
            anchors.left:parent.right
            anchors.leftMargin:2
            anchors.top:parent.top
            color:"white"
            text:{
            switch(current_base) {
                case 1: i18n.tr("Living");break;
                case 2: i18n.tr("Soil");break;
                case 3: i18n.tr("Sand");break;
                case 4: i18n.tr("Ice");break;
                case 5: i18n.tr("Rock");break;
                default:i18n.tr("No Base Texture");break;
                }
             }


            Text {
                anchors.left:parent.left

                anchors.top:parent.bottom
                color:"white"
                text:{
                switch(current_cf) {
                    case 1: i18n.tr("Standard Terrain");break;
                    case 2: i18n.tr("Ruff Terrain");break;
                    case 3: i18n.tr("Shallow Water");break;
                    case 4: i18n.tr("Deep Water");break;
                    case 5: i18n.tr("Tainted Water");break;
                    case 6: i18n.tr("Deadly Fluid");break;
                    default:i18n.tr("No Terrain");break;
                    }
                 }

                Text {
                    anchors.left:parent.left

                    anchors.top:parent.bottom
                    color:"white"
                    text:{
                    switch(current_cw) {
                        case 1: i18n.tr("Wall");break;
                        case 2: i18n.tr("Wall");break;
                        case 3: i18n.tr("Wall");break;
                        case 4: i18n.tr("Wall");break;
                        case 5: i18n.tr("Wall");break;
                        case 6: i18n.tr("Wall");break;
                        case 7: i18n.tr("Wall");break;
                        case 8: i18n.tr("Wall");break;
                        case 9: i18n.tr("Wall");break;
                        case 10: i18n.tr("Wall");break;
                        case 11: i18n.tr("Wall");break;
                        case 12: i18n.tr("Wall");break;
                        default:i18n.tr("No Wall");break;
                        }
                     }
                    }


                }


            }
          }

        Image {
            z:1
            anchors.top:parent.top
            anchors.right:parent.right
            anchors.margins:10
            source:if(quickfill == 1) {"graphics/multi.png"} else {"graphics/single.png"}
            width:parent.width * 0.10
            height:parent.width * 0.10
        }

    }

    Rectangle {
        id:layer_picker
        anchors.left:parent.left
        anchors.top:parent.top
        anchors.margins:10
        height:parent.height * 0.04
        width:parent.height * 0.04
        radius:width / 2
        color:UbuntuColors.coolGrey
        border.color:UbuntuColors.lightGrey

        Image {
            anchors.centerIn: parent
            width:parent.width * 0.5
            height:parent.width * 0.5
            source:"/usr/share/icons/suru/actions/scalable/navigation-menu.svg"
        }

        MouseArea {
            anchors.fill:parent
            onClicked:if(layers.state =="Show") {layers.state ="Hide"} else {layers.state = "Show"}
        }

        Column {
            id:layers
            anchors.top:parent.bottom
            width:parent.width
            //height:parent.height * 4
            spacing:4
            clip:true

            states: [
                State {
                    name:"Show"
                    PropertyChanges {
                        target: layers
                        height:parent.height * 4
                        opacity:1

                    }
                },

                State {
                    name:"Hide"
                    PropertyChanges {
                        target: layers
                        height:0
                        opacity:0

                    }
                }


            ]

            transitions: [
                Transition {
                    from: "Hide"
                    to: "Show"

                    NumberAnimation {
                        target: layers
                        property: "height"
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }

                },

                Transition {
                    from: "Show"
                    to: "Hide"

                    NumberAnimation {
                        target: layers
                        property: "height"
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }

                }


            ]

            state:"Hide"

            Rectangle {
                id:terrain
                height:layer_picker.height
                width:layer_picker.height
                radius:width / 2
                color:UbuntuColors.coolGrey
                border.color:UbuntuColors.lightGrey

                Image {
                    anchors.fill:parent
                    source:"graphics/map/terrain.png"
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:layers.state = "Hide",location_options.state = "Show",enemy_options.state ="Hide",items_options.state ="Hide",enemybox.state = "Hide",toolbox.state = "Show",currentlayer = 1;
                }
        }

            Rectangle {
                id:enemies
                height:layer_picker.height
                width:layer_picker.height
                radius:width / 2
                color:UbuntuColors.coolGrey
                border.color:UbuntuColors.lightGrey

                Image {
                    anchors.centerIn: parent
                    width:parent.width * 0.65
                    height:parent.width * 0.65
                    source:"graphics/map/enemy.png"
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:layers.state = "Hide",location_options.state ="Hide",enemy_options.state ="Show",items_options.state ="Hide",enemybox.state = "Show",toolbox.state = "Hide",currentlayer = 2;
                }
        }

            Rectangle {
                id:items
                height:layer_picker.height
                width:layer_picker.height
                radius:width / 2
                color:UbuntuColors.coolGrey
                border.color:UbuntuColors.lightGrey

                Image {
                    anchors.centerIn: parent
                    width:parent.width * 0.65
                    height:parent.width * 0.65
                    source:"graphics/map/items.png"
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:layers.state = "Hide",location_options.state ="Hide",enemy_options.state ="Hide",items_options.state ="Show",enemybox.state = "Hide",toolbox.state = "Hide",currentlayer = 3;
                }
        }


        }

    }

    Rectangle {
        id:location_options

        anchors.top:parent.top
        height:parent.height
        width:parent.width * 0.20
        radius:8
        color:UbuntuColors.coolGrey
        border.color:UbuntuColors.lightGrey

        states: [
            State {
                name: "Show"
                PropertyChanges {
                    target:location_options
                    x:parent.width - width
                }
            },
            State {
                name: "Hide"
                PropertyChanges {
                    target:location_options
                    x:parent.width
                }
            }

        ]

        transitions: [
            Transition {
                from: "Hide"
                to: "Show"

                NumberAnimation {
                    target: location_options
                    property: "x"
                    duration: 400
                    easing.type: Easing.InOutQuad
                }

            },

            Transition {
                from: "Show"
                to: "Hide"

                NumberAnimation {
                    target: location_options
                    property: "x"
                    duration: 400
                    easing.type: Easing.InOutQuad
                }

            }


        ]


        state:"Show"


        Column {
            id:roomcolumn
            width:parent.width
            height:parent.height
            spacing:10

            Item {
                width:parent.width
                height:locale.height + locale.y

            Text {
                text:i18n.tr("Location:")
                color:"white"
                x:4
                font.pixelSize: roomcolumn.height * 0.025
                TextField {
                    id:locale
                    anchors.top:parent.bottom
                    anchors.topMargin:6
                    width:roomcolumn.width * 0.96
                    text:maptitle
                    onTextChanged: maptitle = text,autosave.running = true;
                }
            }
            }
            Item {
                width:parent.width
                height:discription.height + discription.y

            Text {
                text:i18n.tr("Discription:")
                color:"white"
                x:4
                font.pixelSize: roomcolumn.height * 0.025
                TextArea {
                    id:discription
                    anchors.top:parent.bottom
                    anchors.topMargin:6
                    width:roomcolumn.width * 0.96
                    height: roomcolumn.height / 2
                    text:mapdiscription
                    onTextChanged: mapdiscription = text,autosave.running = true;

                }
            }
            }


        }
    }


    Rectangle {
        id:enemy_options

        anchors.top:parent.top
        height:parent.height
        width:parent.width * 0.20
        radius:8
        color:UbuntuColors.coolGrey
        border.color:UbuntuColors.lightGrey

        states: [
            State {
                name: "Show"
                PropertyChanges {
                    target:enemy_options
                    x:parent.width - width
                }
            },
            State {
                name: "Hide"
                PropertyChanges {
                    target:enemy_options
                    x:parent.width
                }
            }

        ]

        transitions: [
            Transition {
                from: "Hide"
                to: "Show"

                NumberAnimation {
                    target: enemy_options
                    property: "x"
                    duration: 400
                    easing.type: Easing.InOutQuad
                }

            },

            Transition {
                from: "Show"
                to: "Hide"

                NumberAnimation {
                    target: enemy_options
                    property: "x"
                    duration: 400
                    easing.type: Easing.InOutQuad
                }

            }


        ]


        state:"Hide"


        Column {
            y:parent.height * 0.01
            x:parent.width * 0.01
            id:enroomcolumn
            width:parent.width * 0.99
            height:parent.height * 0.99
            spacing:10

            Text {
                text:"Conflict:"
                font.pixelSize: parent.width * 0.1
                color:"White"
            }
            Text {
                text:"Current Encounter Level:"+el
                font.pixelSize: parent.width * 0.08
                color:"White"
            }
            Rectangle {
                color:"grey"
                height: 4
                width: enroomcolumn.width * 0.98
            }

            Row {
                width:parent.width
                spacing:enroomcolumn.width * 0.05

                Item {
                    width:min.width + min.x
                    height:min.height

                    Text {
                        text:"Min Lvl: "
                        font.pixelSize: parent.width * 0.13
                        color:"white"
                        anchors.verticalCenter: parent.verticalCenter

                        TextField {
                            id:min
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left:parent.right
                            maximumLength: 3
                            width:enroomcolumn.width * 0.22
                        }
                    }
                }
                Item {
                    width:max.width + max.x
                    height:max.height

                    Text {
                        text:"Max Lvl: "
                        font.pixelSize: parent.width * 0.13
                        color:"white"
                        anchors.verticalCenter: parent.verticalCenter

                        TextField {
                            id:max
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left:parent.right
                            maximumLength: 3
                            width:enroomcolumn.width * 0.22
                        }
                    }
                }
            }

            Rectangle {
                color:"grey"
                height: 4
                width: enroomcolumn.width * 0.98
            }


            Item {
                width:parent.width
                height:combatants.height + combatants.y

            Text {
                text:i18n.tr("Combatants:")
                color:"white"
                x:4
                font.pixelSize: enroomcolumn.height * 0.025

                Rectangle {
                    width:combatants.width
                    height:combatants.height * 1.05
                    color:UbuntuColors.coolGrey
                    anchors.centerIn: combatants
                    radius:8
                    border.color: "gray"
                }

                GridView {
                    id:combatants
                    anchors.top:parent.bottom
                    anchors.topMargin:15
                    clip:true
                    width:enroomcolumn.width * 0.96
                    height: enroomcolumn.height / 3.5
                    cellHeight:combatants.height *0.08
                    cellWidth:combatants.width



                    model: ListModel {
                        id:enemylist

                        ListElement {
                            enemy_name:"bad guy"
                        }
                    }

                    delegate :

                        Item {

                            height:combatants.cellHeight
                            width:combatants.cellWidth

                            Rectangle {
                                x:combatants.cellWidth * 0.01
                                width:combatants.cellWidth * 0.98
                                height:combatants.cellHeight * 0.90
                                color:"gray"
                                border.color:"gray"

                                Text {
                                    x:parent.width * 0.04
                                    text:enemy_name
                                    font.pixelSize: parent.height * 0.6
                                    color:"white"
                                    anchors.verticalCenter: parent.verticalCenter
                                    width:parent.width * 0.90
                                    clip:true
                                }

                                Rectangle {
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.right:parent.right
                                    anchors.rightMargin: 10
                                    width:parent.height * 0.70
                                    height:parent.height * 0.70
                                    radius:width / 2
                                    color:UbuntuColors.darkGrey

                                }
                            }

                    }

                }
            }
            }

            Item {
                width:parent.width
                height:npcs.height + npcs.y

            Text {
                text:i18n.tr("NPCs:")
                color:"white"
                x:4
                font.pixelSize: enroomcolumn.height * 0.025

                Rectangle {
                    width:npcs.width
                    height:npcs.height * 1.05
                    color:UbuntuColors.coolGrey
                    anchors.centerIn: npcs
                    radius:8
                    border.color: "gray"
                }

                GridView {
                    id:npcs
                    anchors.top:parent.bottom
                    anchors.topMargin:15
                    clip:true
                    width:enroomcolumn.width * 0.96
                    height: enroomcolumn.height / 3.5
                    cellHeight:combatants.height *0.08
                    cellWidth:combatants.width



                    model: ListModel {
                        id:npclist

                        ListElement {
                            name:"good guy"
                        }
                    }

                    delegate :

                        Item {

                            height:npcs.cellHeight
                            width:npcs.cellWidth

                            Rectangle {
                                x:npcs.cellWidth * 0.01
                                width:npcs.cellWidth * 0.98
                                height:npcs.cellHeight * 0.90
                                color:"gray"
                                border.color:"gray"

                                Text {
                                    x:parent.width * 0.04
                                    text:name
                                    font.pixelSize: parent.height * 0.6
                                    color:"white"
                                    anchors.verticalCenter: parent.verticalCenter
                                    width:parent.width * 0.90
                                    clip:true
                                }

                                Rectangle {
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.right:parent.right
                                    anchors.rightMargin: 10
                                    width:parent.height * 0.70
                                    height:parent.height * 0.70
                                    radius:width / 2
                                    color:UbuntuColors.darkGrey

                                }
                            }

                    }

                }
            }
            }







        }
    }

    Rectangle {
        id:items_options

        anchors.top:parent.top
        height:parent.height
        width:parent.width * 0.20
        radius:8
        color:UbuntuColors.coolGrey
        border.color:UbuntuColors.lightGrey

        states: [
            State {
                name: "Show"
                PropertyChanges {
                    target:items_options
                    x:parent.width - width
                }
            },
            State {
                name: "Hide"
                PropertyChanges {
                    target:items_options
                    x:parent.width
                }
            }

        ]

        transitions: [
            Transition {
                from: "Hide"
                to: "Show"

                NumberAnimation {
                    target: items_options
                    property: "x"
                    duration: 400
                    easing.type: Easing.InOutQuad
                }

            },

            Transition {
                from: "Show"
                to: "Hide"

                NumberAnimation {
                    target: items_options
                    property: "x"
                    duration: 400
                    easing.type: Easing.InOutQuad
                }

            }


        ]


        state:"Hide"


        Column {
            id:iroomcolumn
            width:parent.width
            height:parent.height
            spacing:10

            Text {
                text:"Stationaries:"
                font.pixelSize: parent.width * 0.1
                color:"White"
            }

            Item {
                width:parent.width
                height:item.height + item.y

            Text {
                text:i18n.tr("Treasures and Drops:")
                color:"white"
                x:4
                font.pixelSize: iroomcolumn.height * 0.025

                Rectangle {
                    width:item.width
                    height:item.height * 1.05
                    color:UbuntuColors.coolGrey
                    anchors.centerIn: item
                    radius:8
                    border.color: "gray"
                }

                GridView {
                    id:item
                    anchors.top:parent.bottom
                    anchors.topMargin:15
                    clip:true
                    width:iroomcolumn.width * 0.96
                    height: iroomcolumn.height / 3.5
                    cellHeight:item.height *0.08
                    cellWidth:item.width



                    model: ListModel {
                        id:itemlist

                        ListElement {
                            enemy_name:"Potion"
                        }
                    }

                    delegate :

                        Item {

                            height:item.cellHeight
                            width:item.cellWidth

                            Rectangle {
                                x:item.cellWidth * 0.01
                                width:item.cellWidth * 0.98
                                height:item.cellHeight * 0.90
                                color:"gray"
                                border.color:"gray"

                                Text {
                                    x:parent.width * 0.04
                                    text:enemy_name
                                    font.pixelSize: parent.height * 0.6
                                    color:"white"
                                    anchors.verticalCenter: parent.verticalCenter
                                    width:parent.width * 0.90
                                    clip:true
                                }

                                Rectangle {
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.right:parent.right
                                    anchors.rightMargin: 10
                                    width:parent.height * 0.70
                                    height:parent.height * 0.70
                                    radius:width / 2
                                    color:UbuntuColors.darkGrey

                                }
                            }

                    }

                }
            }
            }

            Item {
                width:parent.width
                height:traps.height + traps.y

            Text {
                text:i18n.tr("Traps:")
                color:"white"
                x:4
                font.pixelSize: iroomcolumn.height * 0.025

                Rectangle {
                    width:traps.width
                    height:traps.height * 1.05
                    color:UbuntuColors.coolGrey
                    anchors.centerIn: traps
                    radius:8
                    border.color: "gray"
                }

                GridView {
                    id:traps
                    anchors.top:parent.bottom
                    anchors.topMargin:15
                    clip:true
                    width:iroomcolumn.width * 0.96
                    height: iroomcolumn.height / 3.5
                    cellHeight:traps.height *0.08
                    cellWidth:traps.width



                    model: ListModel {
                        id:traplist

                        ListElement {
                            name:"Trap!!!"
                        }
                    }

                    delegate :

                        Item {

                            height:traps.cellHeight
                            width:traps.cellWidth

                            Rectangle {
                                x:traps.cellWidth * 0.01
                                width:traps.cellWidth * 0.98
                                height:traps.cellHeight * 0.90
                                color:"gray"
                                border.color:"gray"

                                Text {
                                    x:parent.width * 0.04
                                    text:name
                                    font.pixelSize: parent.height * 0.6
                                    color:"white"
                                    anchors.verticalCenter: parent.verticalCenter
                                    width:parent.width * 0.90
                                    clip:true
                                }

                                Rectangle {
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.right:parent.right
                                    anchors.rightMargin: 10
                                    width:parent.height * 0.70
                                    height:parent.height * 0.70
                                    radius:width / 2
                                    color:UbuntuColors.darkGrey

                                }
                            }

                    }

                }
            }
            }


        }
    }







    MapTools {
        id:toolbox
        state:"Show"
        x:parent.width * 0.60
        width:parent.width * 0.13
        height:parent.width * 0.13

    }


    EnemyTools {
        id:enemybox
        state:"Hide"
        x:parent.width * 0.50
        y:parent.height * 0.60
        width:parent.width * 0.28
        height:parent.width * 0.18

    }

    ItemTools {
        id:itembox
        state:"Hide"
        x:parent.width * 0.60
        width:parent.width * 0.13
        height:parent.width * 0.13

    }



Item {
    id:maps
    state:"Hide"
    anchors.horizontalCenter: mapflick.horizontalCenter


    width:parent.width * 0.20
    height:parent.width * 0.13



    states: [

        State {
            name:"Show"

            PropertyChanges {
                target:maps
                y:-(height * 0.05)
            }

        },
        State {
            name:"Hide"

            PropertyChanges {
                target:maps
                y:-(height * 0.85)

            }
        }


    ]

    transitions: [
        Transition {
            from: "Hide"
            to: "Show"
            NumberAnimation {
                target: maps
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        },

        Transition {
            from: "Show"
            to: "Hide"
            NumberAnimation {
                target: maps
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

    ]

    onStateChanged: if(maps.state == "Show")  {Scripts.listmaps(storyid)}

    Rectangle {
        id:window
        z:0
        width:parent.width * 0.99
        anchors.centerIn: parent
        height:parent.height * 0.95
        radius:8
        color:UbuntuColors.coolGrey
        border.color:UbuntuColors.warmGrey


        Rectangle {
            anchors.fill:options
            radius:8
            anchors.margins: -10
            color:UbuntuColors.warmGrey
            border.color:UbuntuColors.darkAubergine
        }

        GridView {
            id:listgrid
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:label.top
            anchors.top:parent.top
            anchors.topMargin:parent.height * 0.05
            width:parent.width * 0.98
            cellWidth:parent.width
            cellHeight:parent.height * 0.20
            clip:true

            model: ListModel {
                id:maplist


            }

            delegate:  Item {
                        width:listgrid.cellWidth* 0.98
                        height:listgrid.cellHeight * 0.98


                        Rectangle {
                            id:backing
                            color:UbuntuColors.coolGrey
                            anchors.fill:parent
                        }

                        Text {

                            width:parent.width
                            height:parent.height
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            text:name
                            color:"white"
                            font.pixelSize: parent.height * 0.5
                        }


                        MouseArea {
                            width:parent.width
                            height:parent.height
                            hoverEnabled: true
                            onEntered: backing.color = "gray";
                            onExited: backing.color = UbuntuColors.coolGrey;
                            onClicked: Scripts.load_map(themap),mapid = themap,storyid = thestory,maps.state = "Hide",maplist.clear()
                        }

            }


        }

        Rectangle {
            id:lbacking
            color:UbuntuColors.coolGrey
            anchors.centerIn:label
            width:maps.width * 0.98
            height:label.height
            radius:8

            MouseArea {
                width:maps.width
                height:parent.height
                onClicked: if(maps.state == "Show")  {maps.state = "Hide",maplist.clear(),autosave.running = false,Scripts.clearmap()} else {maps.state = "Show"}
                hoverEnabled: true
                onEntered: lbacking.color = "gray";
                onExited: lbacking.color = UbuntuColors.coolGrey;
            }
        }

        Text {
            id:label
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:parent.bottom
            anchors.bottomMargin:2

            text:if(maps.state == "Show") {i18n.tr("New Location")} else {i18n.tr("Locations")}
            color:"white"
            font.pixelSize:parent.height * 0.1


        }
    }


}

InfoPopUp {
    id:infoview

    state:"Hide"
}




//nothing below this point
}
