import QtQuick 2.4
import Ubuntu.Components 1.3
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.1
import "Main.js" as Scripts


Item {
property int where: 1
property string preview: ""


//width:parent.width
//height:parent.height
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

onStateChanged: if(window_container.state == "Show") {}


Rectangle {
    color:UbuntuColors.coolGrey
    anchors.fill:parent
    radius:width / 2
    border.color:Qt.rgba(0.4,0.4,0.4,0.8)
    border.width:10
    clip:true


    Rectangle {
        id:closebutton
        anchors.centerIn: parent
        width:parent.width * 0.2
        height:parent.width * 0.2
        radius: width / 2
        border.color: "grey"
        color:UbuntuColors.coolGrey


        Image {
            source:"graphics/gear.png"
            anchors.centerIn: parent
            width:parent.width * 0.80
            height:parent.width * 0.80
            fillMode:Image.PreserveAspectFit
        }

        MouseArea {
            anchors.fill:parent
            onPressed:closebutton.color = "grey"
            drag.target: window_container
            drag.axis: Drag.XAndYAxis
            drag.minimumX: 0
            drag.minimumY: 0
            drag.maximumX: mapflick.width - window_container.width
            drag.maximumY: mapflick.height - window_container.height

            hoverEnabled: true
            onEntered: closebutton.color = "grey"
            onExited: closebutton.color = UbuntuColors.coolGrey

            onClicked:current_cf = 0,current_cw = 0,current_base =0

        }
    }

    Rectangle {
     id:p1
     anchors.right:closebutton.left
     anchors.bottom:closebutton.bottom
     anchors.rightMargin:10
     width:parent.width * 0.22
     height:parent.height * 0.22
        border.color:if(current_base == 1) {"gold"} else {"gray"}
     color:"#034405"


     MouseArea {
         anchors.fill:parent
         onClicked:current_base = 1;
     }

    }


    Rectangle {
     id:p2
     anchors.right: p3.left
     anchors.bottom:p1.top
     anchors.margins: 3
     width:parent.width * 0.18
     height:parent.height * 0.18
     border.color:if(current_base == 2) {"gold"} else {"gray"}
     color:Qt.rgba(0.5,0.3,0.1,1)

     MouseArea {
         anchors.fill:parent
         onClicked:current_base = 2;
     }

    }


    Rectangle {
     id:p3
     anchors.bottom:closebutton.top
     anchors.bottomMargin: 10
     anchors.horizontalCenter: parent.horizontalCenter
     width:parent.width * 0.22
     height:parent.height * 0.22
        border.color:if(current_base == 3) {"gold"} else {"gray"}
       color: "#ACA069"

       MouseArea {
           anchors.fill:parent
           onClicked:current_base = 3;
       }
    }

    Rectangle {
     id:p4
     anchors.left: p3.right
     anchors.bottom:p5.top
     anchors.margins: 3
     width:parent.width * 0.18
     height:parent.height * 0.18
     border.color:if(current_base == 4) {"gold"} else {"gray"}
     color:"#86c6fd"

     MouseArea {
         anchors.fill:parent
         onClicked:current_base = 4;
     }

    }


    Rectangle {
     id:p5
     anchors.bottom:closebutton.bottom
     anchors.left:closebutton.right
     anchors.leftMargin: 10
        border.color:if(current_base == 5) {"gold"} else {"gray"}
     width:parent.width * 0.22
     height:parent.height * 0.22
     color:"#d4d8dc"

     MouseArea {
         anchors.fill:parent
         onClicked:current_base = 5;
     }

    }


        Row {
            id:row1
            anchors.top:closebutton.bottom
            anchors.topMargin:4
            width:parent.width * 0.75
            anchors.horizontalCenter:parent.horizontalCenter
            clip:true
            spacing:4

            Rectangle {
                width:parent.width * .14
                height:parent.width * .14
                //radius:4
                border.color:if(current_cw == 1) {"gold"} else {"gray"}

                color:"gray"

                Image {
                    anchors.centerIn: parent
                    width:parent.width * 0.70
                    height:parent.height * 0.99
                    source: "graphics/map/wall_vl.png"
                }
                MouseArea {
                    anchors.fill:parent
                    onClicked:{
                        if(current_cw == 1) {current_cw = 0;} else {current_cw = 1;}
                    }
                }

            }
            Rectangle {
                width:parent.width * .14
                height:parent.width * .14
                //radius:4
                border.color:if(current_cw == 13) {"gold"} else {"gray"}
                color:"gray"
                Image {
                    anchors.centerIn: parent
                    width:parent.width * 0.70
                    height:parent.height * 0.99
                    source: "graphics/map/ledge4_vl.png"
                }
                MouseArea {
                    anchors.fill:parent
                    onClicked:if(current_cw == 13) {current_cw = 0;} else {current_cw = 13;}
                }
            }
            Rectangle {
                width:parent.width * .14
                height:parent.width * .14
                border.color:if(current_cw == 14) {"gold"} else {"gray"}
                //radius:4
                color:"gray"
                Image {
                    anchors.centerIn: parent
                    width:parent.width * 0.70
                    height:parent.height * 0.99
                    source: "graphics/map/ledge4_vr.png"
                }
                MouseArea {
                    anchors.fill:parent
                    onClicked:if(current_cw == 14) {current_cw = 0;} else {current_cw = 14;}
                }
            }
            Rectangle {
                width:parent.width * .14
                height:parent.width * .14
                border.color:if(current_cw == 2) {"gold"} else {"gray"}
                //radius:4
                color:"gray"
                Image {
                    anchors.centerIn: parent
                    width:parent.width * 0.70
                    height:parent.height * 0.99
                    source: "graphics/map/wall_vr.png"
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:if(current_cw == 2) {current_cw = 0;} else {current_cw = 2;}
                }
            }
            Rectangle {
                width:parent.width * .14
                height:parent.width * .14
                border.color:if(current_cf == 2) {"gold"} else {"gray"}
                //radius:4
                color:"gray"
                Image {
                    anchors.centerIn: parent
                    width:parent.width * 0.90
                    height:parent.height * 0.90
                    source: "graphics/map/ruff_terrain.png"
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:current_cf = 2;
                }
            }
            Rectangle {
                width:parent.width * .14
                height:parent.width * .14
               border.color:if(current_cf == 3) {"gold"} else {"gray"}
                //radius:4
                color:"gray"
                Image {
                    anchors.centerIn: parent
                    width:parent.width * 0.90
                    height:parent.height * 0.90
                    source: "graphics/map/shallow_water.png"
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:current_cf = 3;
                }
            }


        }

        Row {
            id:row2
            anchors.top:row1.bottom
            anchors.topMargin:4
            width:parent.width * 0.5
            anchors.horizontalCenter:parent.horizontalCenter
            clip:true
            spacing:4

            Rectangle {
                width:row1.width * .14
                height:row1.width * .14
                //radius:4
                border.color:if(current_cf == 4) {"gold"} else {"gray"}
                color:"gray"

                Image {
                    anchors.centerIn: parent
                    width:parent.width * 0.90
                    height:parent.height * 0.90
                    source: "graphics/map/deep_water.png"
                }
                MouseArea {
                    anchors.fill:parent
                    onClicked:current_cf = 4;
                }

            }
            Rectangle {
                width:row1.width * .14
                height:row1.width * .14
                //radius:4
                border.color:if(current_cf == 5) {"gold"} else {"gray"}
                color:"gray"

                Image {
                    anchors.centerIn: parent
                    width:parent.width * 0.90
                    height:parent.height * 0.90
                    source: "graphics/map/tainted_water.png"
                }
                MouseArea {
                    anchors.fill:parent
                    onClicked:current_cf = 5;
                }
            }
            Rectangle {
                width:row1.width * .14
                height:row1.width * .14
                border.color:if(current_cf == 6) {"gold"} else {"gray"}
                //radius:4
                color:"gray"

                Image {
                    anchors.centerIn: parent
                    width:parent.width * 0.90
                    height:parent.height * 0.90
                    source: "graphics/map/deadly_fluid.png"
                }
                MouseArea {
                    anchors.fill:parent
                    onClicked:current_cf = 6;
                }
            }

            Rectangle {
                width:row1.width * .14
                height:row1.width * .14
                border.color:"grey"
                //radius:4
                color:"gray"

                /*Image {
                    anchors.centerIn: parent
                    width:parent.width * 0.90
                    height:parent.height * 0.90
                    source: "graphics/map/shallow_water.png"
                } */

                MouseArea {
                    anchors.fill:parent
                    onClicked:current_cf = 0,current_cw = 0,current_base =0
                }
            }

        }





}






}
