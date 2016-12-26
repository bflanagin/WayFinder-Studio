import QtQuick 2.4
import "Main.js" as Scripts


Item {

   property int num: 0
    property int row: 0
    property int column: 0
   //property int ctile:4
    //anchors.fill:parent
    property int cw_tile:0
    property int cf_tile:0
    property int base_tile:0
    property int level_tile:0
    property int size: 1
    property int anchor:1



Rectangle {

    anchors.fill:parent
    color: {
        switch(base_tile) {
        case 1:Qt.rgba(0.4,0.1,0.1,0.4);break;

        default:Qt.rgba(0.1,0.1,0.1,0.00);break;
    }
    }





}

Image {
    id:currentenemy
    width:parent.width * size
    height:parent.height * size
    source:{
        switch(cf_tile) {
        case 1:"graphics/enemies/redg.png";break;
        case 2:"graphics/enemies/blueg.png";break;
        case 3:"graphics/enemies/greeng.png";break;
        case 4:"graphics/enemies/yellowg.png";break;
        case 5:"graphics/enemies/purpleg.png";break;
        default:"graphics/enemies/none.png";break;
           }
    }

    //opacity:if(anchor == 1) {1} else {0}

}


Image {
    id:current_wall
    anchors.fill:parent
    source:{
        switch(cw_tile) {

           default:return "graphics/map/standard_terrain.png";break;
           }
    }


   // visible:if(ctile != 0) {true} else {false}

}

Rectangle {

    anchors.fill:parent
    color: {
        switch(level_tile) {
        case 1:Qt.rgba(0.8,0.8,0.8,0.2);break;
        case 2: Qt.rgba(0.8,0.8,0.8,0.3);break;
        case 3:Qt.rgba(0.8,0.8,0.8,0.4);break;
        case 4:"#86c6fd";break;
        case 5:"#d4d8dc";break;
        default:Qt.rgba(0.8,0.8,0.8,0.0);break;
    }
    }

    //border.color:"gray"



}


MouseArea {
    anchors.fill:parent
    onClicked:if(cf_tile == 0) {cf_tile = current_enemy, size = enemy_size} else {infoview.state = "Show" }
    hoverEnabled: if(currentlayer == 2) {true} else {false, base_tile = 0}
    onEntered: if(cf_tile != 0) {

                   infoview.x = parent.x
                   infoview.y = parent.y

                   infoview.width = parent.width * 6
                   infoview.height = parent.height * 7
                   infoview.state = "Show"
               } else {
                   if(current_enemy != 0) {
                        current_highlight = num;
                   }


                    }


    enabled: if(currentlayer == 2) {true} else {false}

}




}
