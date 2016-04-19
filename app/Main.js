var component;
var tilenum = 0;


function mapgrid() {


  var  maxColumn = 45;
  var maxRow = 60;
 var  maxIndex = maxRow * maxColumn;
    //var tilenum = 0;

     //tiles = new Array(maxIndex);

   //Initialize Board
   for (var column = 0; column < maxColumn; column++) {
      for (var row = 0; row < maxRow; row++) {

           createBlock(column, row, tilenum);
            tilenum= tilenum +1;
       }
   }


}

function createBlock(column, row, num) {

    if (component == null)
        component = Qt.createComponent("./Tile.qml");

    // Note that if tile.qml was not a local file, component.status would be
    // Loading and we should wait for the component's statusChanged() signal to
    // know when the file is downloaded and ready before calling createObject().

    if (component.status == Component.Ready) {
        var dynamicObject = component.createObject(maparea);
        if (dynamicObject == null) {
            console.log("error creating block");
            console.log(component.errorString());
            return false;
        }
        var blockSizex = maparea.width /50.7;
        var blockSizey = maparea.width /50.7;


        dynamicObject.x =(column * blockSizex);
        dynamicObject.y =(row * blockSizey);

        dynamicObject.width = blockSizex * 1.0;
        dynamicObject.height = blockSizey *1.0;

        dynamicObject.num = num;
        dynamicObject.row = row;
        dynamicObject.column = column;
       //tiles[num] = dynamicObject;


    } else {
        console.log("error loading block component");
        console.log(component.errorString());
        return false;
    }

    return true;
}
