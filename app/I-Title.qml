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



Rectangle {

    anchors.fill:parent
    color: {
        switch(base_tile) {
        case 1: "#034405";break;
        case 2: Qt.rgba(0.5,0.3,0.1,1);break;
        case 3:"#ACA069";break;
        case 4:"#86c6fd";break;
        case 5:"#d4d8dc";break;
        default:Qt.rgba(0.5,0.5,0.5,0.00);break;
    }
    }

    border.color:"blue"



}

Image {
    id:current_floor
    anchors.fill:parent
    source:{
        switch(cf_tile) {
           case 1: return "graphics/map/standard_terrain.png";break;
           case 2: return "graphics/map/ruff_terrain.png";break;
           case 3: return "graphics/map/shallow_water.png";break;
           case 4: return "graphics/map/deep_water.png";break;
           case 5: return "graphics/map/tainted_water.png";break;
           case 6: return "graphics/map/deadly_fluid.png";break;
          // case 7: return "graphics/map/tainted_terrain.png";break;
          // case 8: return "graphics/map/tainted_terrain.png";break;
          // case 9: return "graphics/map/tainted_terrain.png";break;

           default:return "graphics/map/standard_terrain.png";break;
           }
    }

    opacity:0.5

}


Image {
    id:current_wall
    anchors.fill:parent
    source:{
        switch(cw_tile) {
           case 1: return "graphics/map/wall_vl.png";break;
           case 2: return "graphics/map/wall_vr.png";break;
           case 3: return "graphics/map/wall_th.png";break;
           case 4: return "graphics/map/wall_bh.png";break;
           case 7: return "graphics/map/wallcorner_ur.png";break;
           case 8: return "graphics/map/wallcorner_ul.png";break;
           case 9: return "graphics/map/wallcorner_ll.png";break;
           case 10: return "graphics/map/wallcorner_lr.png";break;
           case 11: return "graphics/map/wallangled_r.png";break;
           case 12: return "graphics/map/wallangled_l.png";break;
           case 13: return "graphics/map/ledge4_vl.png";break;
           case 14: return "graphics/map/ledge4_vr.png";break;

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
        default:Qt.rgba(0.8,0.8,0.8,0.1);break;
    }
    }

    //border.color:"gray"



}


MouseArea {
    anchors.fill:parent
    onClicked:cf_tile =current_cf,base_tile = current_base,cw_tile = current_cw
    onDoubleClicked: if(quickfill == 1) {quickfill = 0} else {quickfill = 1,cf_tile =current_cf,base_tile = current_base,cw_tile = current_cw}
    //onReleased:quickfill = 0
    hoverEnabled: true
    onEntered: if(quickfill == 1) {cf_tile =current_cf,base_tile = current_base,cw_tile = current_cw}
    //onPressAndHold: toolbox.state = "Show",toolbox.x =parent.x +parent.width,toolbox.y = parent.y - parent.height


}




}
