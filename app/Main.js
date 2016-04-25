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

function loaddb() {
    console.log("running Load DB");




    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    var data = [id,username];

    var testStr = "SELECT  *  FROM USER WHERE 1";

        db.transaction(function(tx) {
          //tx.executeSql("DROP TABLE USER");
            tx.executeSql('CREATE TABLE IF NOT EXISTS USER (id TEXT, name TEXT)');

             var pull =  tx.executeSql(testStr);

            console.log(pull.rows.length);

            if(pull.rows.length == 0) {
                os_connect.state = "Show";
            } else {
                id = pull.rows.item(0).id;
                username = pull.rows.item(0).name;
            }




        });



}


function artuserdb(go) {


    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);



    var testStr = "SELECT  *  FROM ARTUSER WHERE 1";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS ARTUSER (id TEXT, store TEXT,name TEXT,discription TEXT,contact TEXT,public INT,commissions INT,Donations INT,Paypal TEXT,Patreon TEXT,CoinBase TEXT)');

            if(go == "load") {
             var pull =  tx.executeSql(testStr);
                console.log("running Art DB");

            if(pull.rows.length == 0) {
                console.log("No users")

                storename = "";
                artistname = "";
                discription = "";
                contact = "";
                pub = 0
                donations = 0
                commissions = 0
                paypal = "";
                patreon = "";
                coinbase = "";

            } else {
                storename = pull.rows.item(0).store.replace(/&#x27;/g,"'");
                artistname = pull.rows.item(0).name.replace(/&#x27;/g,"'");
                discription = pull.rows.item(0).discription.replace(/&#x27;/g,"'");
                contact = pull.rows.item(0).contact;
                pub = pull.rows.item(0).public;
                donations = pull.rows.item(0).Donations;
                commissions = pull.rows.item(0).commissions;
                paypal = pull.rows.item(0).Paypal;
                patreon = pull.rows.item(0).Patreon;
                coinbase = pull.rows.item(0).CoinBase;


            }
        }
            if(go == "save") {

                var pull =  tx.executeSql(testStr);


               if(pull.rows.length == 0) {
                            var userStr = "INSERT INTO ARTUSER VALUES(?,?,?,?,?,?,?,?,?,?,?)";

                        var data = [id,storename.replace(/\'/g,"&#x27;"),artistname.replace(/\'/g,"&#x27;"),discription.replace(/\'/g,"&#x27;"),contact,pub,commissions,donations,paypal,patreon,coinbase];

                        tx.executeSql(userStr, data);
               } else {
                    var updateUser = "UPDATE ARTUSER SET store='"+storename.replace(/\'/g,"&#x27;")+"', name='"+artistname.replace(/\'/g,"&#x27;")+"', discription='"+discription.replace(/\'/g,"&#x27;")+"', contact='"+contact+"', public='"+pub+"', commissions='"+commissions+"',donations='"+donations+"', Paypal='"+paypal+"', Patreon='"+patreon+"',CoinBase='"+coinbase+"' WHERE id='"+id+"'";
                        tx.executeSql(updateUser);

               }



            }



        });

    load_img("avatar");
    load_img("sample");

}

function store_img(type,image) {

    var db = Sql.LocalStorage.openDatabaseSync("ImageStore", "1.0", "Images", 1);
     var insert = "";
    var testStr = "";
    var pull = "";
    var data = "";
    var updateUser = "";

    var d = new Date();
    var identkey = type+"::"+artname+"::"+d.getTime();


    db.transaction(function(tx) {

        if(type == "avatar" || type == "sample") {
        tx.executeSql('CREATE TABLE IF NOT EXISTS ARTUSER (id TEXT,type TEXT ,imagename TEXT ,imagedata BLOB)');
                        insert = "INSERT INTO ARTUSER VALUES(?,?,?,?)";

             testStr = "SELECT  *  FROM ARTUSER WHERE type='"+type+"'";

             pull =  tx.executeSql(testStr);


           if(pull.rows.length == 0) {

                     data = [id,type,image,image];
                tx.executeSql(insert,data);

           } else {

                updateUser = "UPDATE ARTUSER SET imagename='"+image+"',imagedata='"+image+"' WHERE type='"+type+"'";
               tx.executeSql(updateUser);

           }

        } else {
            tx.executeSql('CREATE TABLE IF NOT EXISTS GALLERY (id TEXT,name TEXT,type TEXT ,imagename TEXT ,race TEXT,class TEXT,download INT,cost DOUBLE,base INT,discription TEXT,ident TEXT)');
                            insert = "INSERT INTO GALLERY VALUES(?,?,?,?,?,?,?,?,?,?,?)";

             testStr = "SELECT  *  FROM GALLERY WHERE imagename='"+image+"'";

             pull =  tx.executeSql(testStr);


           if(pull.rows.length == 0) {

                     data = [id,artname,type,image,race,aclass,download,cost,base,artdiscription.replace(/\'/g,"&#x27;"),identkey];
                tx.executeSql(insert,data);

           } else {

                updateUser = "UPDATE GALLERY SET name='"+artname+"'type='"+type+"',imagename='"+image+"',race='"+race+"',class='"+aclass+"',download='"+download+"',cost='"+cost+"',base='"+base+"',discription='"+artdiscription+",ident='"+identkey+"' WHERE imagename='"+image+"'";
               tx.executeSql(updateUser);

           }




        }



     });

}


function load_img(type) {

    var db = Sql.LocalStorage.openDatabaseSync("ImageStore", "1.0", "Images", 1);


    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS ARTUSER (id TEXT,type TEXT ,imagename TEXT ,imagedata BLOB)');

        var testStr = "SELECT  *  FROM ARTUSER WHERE type ='"+type+"'";

        var pull =  tx.executeSql(testStr);


       if(pull.rows.length != 0) {

          switch (type) {
          case "avatar": avatarimg = pull.rows.item(0).imagename;break;
          case "sample": sampleimg = pull.rows.item(0).imagename;break;
          default:break;
          }

       }

     });

}

function load_gallery() {

    var db = Sql.LocalStorage.openDatabaseSync("ImageStore", "1.0", "Images", 1);


    db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS GALLERY (id TEXT,name TEXT,type TEXT ,imagename TEXT ,race TEXT,class TEXT,download INT,cost DOUBLE,base INT,discription TEXT,ident TEXT)');

        var testStr = "SELECT  *  FROM GALLERY WHERE 1";

        var pull =  tx.executeSql(testStr);
        var itemnum = 0;

        imagelist.append({

                     name:"AddNew",
                     img:"graphics/newImageAdd.png"

                         });

        while(pull.rows.length > itemnum) {

                console.log(pull.rows.item(itemnum).name);

                imagelist.append({
                    name : pull.rows.item(itemnum).name,
                    img : pull.rows.item(itemnum).imagename


                    });


            itemnum = itemnum+1;
        }



    });


}



