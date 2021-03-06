var component;
var ecomponent;
var icomponent;
var excomponent;
var tilenum = 0;

var  maxColumn = 45;
var maxRow = 45;
var  maxIndex = maxRow * maxColumn;


//Tile Arrays //

var tiles = new Array(maxIndex);
var etiles = new Array(maxIndex);
var itiles = new Array(maxIndex);
var extiles = new Array(maxIndex);



function loaddb() {
   // console.log("running Load DB");




    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    var data = [id,username];

    var testStr = "SELECT  *  FROM USER WHERE 1";

        db.transaction(function(tx) {
          //tx.executeSql("DROP TABLE USER");
            tx.executeSql('CREATE TABLE IF NOT EXISTS USER (id TEXT, name TEXT)');

             var pull =  tx.executeSql(testStr);

          //  console.log(pull.rows.length);

            if(pull.rows.length == 0) {
                os_connect.state = "Show";
            } else {
                id = pull.rows.item(0).id;
                username = pull.rows.item(0).name;
            }




        });



}

//Art Store //


function artuserdb(go) {


    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);



    var testStr = "SELECT  *  FROM ARTUSER WHERE 1";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS ARTUSER (id TEXT, store TEXT,name TEXT,discription TEXT,contact TEXT,public INT,commissions INT,Donations INT,Paypal TEXT,Patreon TEXT,CoinBase TEXT)');

            if(go == "load") {
             var pull =  tx.executeSql(testStr);
                //console.log("running Art DB");

            if(pull.rows.length == 0) {
              //  console.log("No users")

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
    var identkey = type+"::"+artname.replace(/\'/g,"&#x27;")+"::"+d.getTime();



    var path = image.split(":;:")[0];
    var idata = image.split(":;:")[1];




    db.transaction(function(tx) {

        if(type == "avatar" || type == "sample") {
        tx.executeSql('CREATE TABLE IF NOT EXISTS ARTUSER (id TEXT,type TEXT ,imagename TEXT ,imagedata BLOB)');
                        insert = "INSERT INTO ARTUSER VALUES(?,?,?,?)";

             testStr = "SELECT  *  FROM ARTUSER WHERE type='"+type+"'";

             pull =  tx.executeSql(testStr);


           if(pull.rows.length == 0) {

                     data = [id,type,path,idata];


                tx.executeSql(insert,data);

           } else {

                updateUser = "UPDATE ARTUSER SET imagename='"+path+"',imagedata='"+idata+"' WHERE type='"+type+"'";



               tx.executeSql(updateUser);

           }

        } else {
            tx.executeSql('CREATE TABLE IF NOT EXISTS GALLERY (id TEXT,name TEXT,type TEXT ,imagename TEXT ,race TEXT,class TEXT,download INT,cost DOUBLE,base INT,discription TEXT,ident TEXT,imagedata BLOB)');
                            insert = "INSERT INTO GALLERY VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";

             testStr = "SELECT  *  FROM GALLERY WHERE imagename='"+path+"'";

             pull =  tx.executeSql(testStr);


           if(pull.rows.length == 0) {

                     data = [id,artname.replace(/\'/g,"&#x27;"),type,path,race,aclass,download,cost,base,artdiscription.replace(/\'/g,"&#x27;"),identkey,idata];
                tx.executeSql(insert,data);

           } else {

                updateUser = "UPDATE GALLERY SET name='"+artname.replace(/\'/g,"&#x27;")+"',type='"+type+"',imagename='"+path+"',race='"+race+"',class='"+aclass+"',download='"+download+"',cost='"+cost+"',base='"+base+"',discription='"+artdiscription.replace(/\'/g,"&#x27;")+"',ident='"+identkey+"',imagedata='"+idata+"' WHERE imagename='"+path+"'";
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


function delete_img(image) {

    var db = Sql.LocalStorage.openDatabaseSync("ImageStore", "1.0", "Images", 1);


    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS GALLERY (id TEXT,name TEXT,type TEXT ,imagename TEXT ,race TEXT,class TEXT,download INT,cost DOUBLE,base INT,discription TEXT,ident TEXT,imagedata BLOB)');

    var testStr = "SELECT  *  FROM GALLERY WHERE imagename = '"+image+"'";

    var pull =  tx.executeSql(testStr);
    var itemnum = 0;

        if(pull.rows.length == 0) {
            console.log("No image found") }
        else {
            console.log("Deleting: "+image);
            var deletefile = "DELETE FROM GALLERY WHERE imagename='"+image+"'";
            tx.executeSql(deletefile);
        }

     });
}

function load_gallery() {

    imagelist.clear();

    var db = Sql.LocalStorage.openDatabaseSync("ImageStore", "1.0", "Images", 1);


    db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS GALLERY (id TEXT,name TEXT,type TEXT ,imagename TEXT ,race TEXT,class TEXT,download INT,cost DOUBLE,base INT,discription TEXT,ident TEXT,imagedata BLOB)');

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
                    img : pull.rows.item(itemnum).imagename,
                    trace :pull.rows.item(itemnum).race,
                    tclass :  pull.rows.item(itemnum).class,
                    type : pull.rows.item(itemnum).type,
                    tdownload : pull.rows.item(itemnum).download,
                    tcost :pull.rows.item(itemnum).cost,
                    tbase : pull.rows.item(itemnum).base,
                    tdiscription : pull.rows.item(itemnum).discription,

                    });


            itemnum = itemnum+1;
        }



    });


}


//adventure mode //


function list_stories() {

    storylist.clear();



    var db = Sql.LocalStorage.openDatabaseSync("Adventures", "1.0", "Story", 1);


    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS STORY (id TEXT,storyid TEXT,title TEXT,author TEXT, contact TEXT ,story TEXT ,summary TEXT,characters TEXT,publish INT,donations INT,paypal TEXT,patreon TEXT,coinbase TEXT,date TEXT,cover TEXT,coverdata BLOB)');

        var testStr = "SELECT  *  FROM STORY WHERE 1";

        var pull =  tx.executeSql(testStr);
        var itemnum = 0;



        storylist.append({

                     name:"Add New",
                     img:"graphics/newImageAdd.png",
                     stories:"noid"

                         });


        while(pull.rows.length > itemnum) {
            var thecover;
            if(pull.rows.item(itemnum).cover == " ") {thecover = "graphics/book.png"} else {thecover = pull.rows.item(itemnum).cover}


            storylist.append({

                         name:pull.rows.item(itemnum).title,
                         img:thecover,
                         stories:pull.rows.item(itemnum).storyid,

                                 theauthor:pull.rows.item(itemnum).author,
                                 thecontact:pull.rows.item(itemnum).contact,
                                 thestory:pull.rows.item(itemnum).story,
                                 thesummary:pull.rows.item(itemnum).summary,
                                 thecharacters:pull.rows.item(itemnum).characters,
                                 thepublished:pull.rows.item(itemnum).publish,
                                 thedonations:pull.rows.item(itemnum).donations,
                                 thepaypal:pull.rows.item(itemnum).paypal,
                                 thepatreon:pull.rows.item(itemnum).patreon,
                                 thecoinbase:pull.rows.item(itemnum).coinbase,
                                 thecreationdate:pull.rows.item(itemnum).date,
                                 thecover:pull.rows.item(itemnum).cover,
                                 thestoryid:pull.rows.item(itemnum).storyid



                             });

            itemnum = itemnum + 1;

        }

         });

}

function save_story() {



    var db = Sql.LocalStorage.openDatabaseSync("Adventures", "1.0", "Story", 1);
    var insert;

    var data;

     var d = new Date();

    if(story_title.length > 2 && author.length > 2 && storyid.length > 2) {

    if (storyid == "noid") {
    storyid = author.replace(/\'/g,"").trim()+"::"+d.getTime()+"::"+story_title.replace(/\'/g,"").trim()
    }



    db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS STORY (id TEXT,storyid TEXT,title TEXT,author TEXT, contact TEXT ,story TEXT ,summary TEXT,characters TEXT,publish INT,donations INT,paypal TEXT,patreon TEXT,coinbase TEXT,date TEXT,cover TEXT,coverdata BLOB)');

        var testStr = "SELECT  *  FROM STORY WHERE storyid ='"+storyid+"'";

        var pull =  tx.executeSql(testStr);
        var itemnum = 0;

       if(pull.rows.length == 0) {


            insert = "INSERT INTO STORY VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
           data = [id,storyid,story_title.replace(/\'/g,"&#x27;"),author.replace(/\'/g,"&#x27;"),story_contact,story.replace(/\'/g,"&#x27;"),story_summary.replace(/\'/g,"&#x27;"),characters,story_pub,story_donations,story_paypal,story_patreon,story_coinbase,pub_date,cover,coverdata];

             tx.executeSql(insert,data);

        } else {

           var updateStory = "UPDATE STORY SET title='"+story_title.replace(/\'/g,"&#x27;")+"',author='"+author+"',contact='"+story_contact+"',story='"+story.replace(/\'/g,"&#x27;")+"',summary='"+story_summary.replace(/\'/g,"&#x27;")+"',characters='"+characters+"',publish='"+story_pub+"',donations='"+story_donations+"',paypal='"+story_paypal+
                   "',patreon='"+story_patreon+"',coinbase='"+story_coinbase+"',date='"+pub_date+"',cover='"+cover+"',coverdata='"+coverdata+"' WHERE storyid='"+storyid+"'";
          tx.executeSql(updateStory);

       }


        });

    }



}


function build_summary() {

    summary.clear();



    var db = Sql.LocalStorage.openDatabaseSync("Adventures", "1.0", "Story", 1);


    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS STORY (id TEXT,storyid TEXT,title TEXT,author TEXT, contact TEXT ,story TEXT ,summary TEXT,characters TEXT,publish INT,donations INT,paypal TEXT,patreon TEXT,coinbase TEXT,date TEXT,cover TEXT,coverdata BLOB)');

        var testStr = "SELECT  *  FROM STORY WHERE storyid='"+storyid+"'";

        var pull =  tx.executeSql(testStr);
        var itemnum = 0;

            summary.append({
                               title:pull.rows.item(itemnum).title,
                               textblock:pull.rows.item(itemnum).story,
                               LoR:itemnum

                            });


        var mapStrs = "SELECT  *  FROM MAPS WHERE storyid='"+storyid+"'";
        var pull2 = tx.executeSql(mapStrs);

         while (itemnum < pull2.rows.length) {
            summary.append({
                               title:pull2.rows.item(itemnum).title,
                               textblock:pull2.rows.item(itemnum).discription,
                               LoR:itemnum+1

                           });

             itemnum = itemnum + 1;
         }

            });





}




function mapgrid() {



   var tilenum = 0;

     //tiles = new Array(maxIndex);

   //Initialize Board

    if(mapcreated == 0) {
   for (var column = 0; column < maxColumn; column++) {
      for (var row = 0; row < maxRow; row++) {

           createBlock(column, row, tilenum,maparea,"base");
            tilenum= tilenum +1;
       }
   }
   mapcreated = 1;
    }


}

function enemygrid() {



   var tilenum = 0;

     //tiles = new Array(maxIndex);

   //Initialize Board

    if(enmapcreated == 0) {
   for (var column = 0; column < maxColumn; column++) {
      for (var row = 0; row < maxRow; row++) {

           create_E_Block(column, row, tilenum,enmaparea,"enemy");
            tilenum= tilenum +1;
       }
   }
   enmapcreated = 1;
    }


}

function itemgrid() {



   var tilenum = 0;

     //tiles = new Array(maxIndex);

   //Initialize Board

    if(imapcreated == 0) {
   for (var column = 0; column < maxColumn; column++) {
      for (var row = 0; row < maxRow; row++) {

           createBlock(column, row, tilenum,imaparea,"items");
            tilenum= tilenum +1;
       }
   }
   imapcreated = 1;
    }


}

function exitgrid() {



   var tilenum = 0;

     //tiles = new Array(maxIndex);

   //Initialize Board

    if(exmapcreated == 0) {
   for (var column = 0; column < maxColumn; column++) {
      for (var row = 0; row < maxRow; row++) {

           createBlock(column, row, tilenum,exmaparea,"exit");
            tilenum= tilenum +1;
       }
   }
   exmapcreated = 1;
    }


}


function createBlock(column,row, num,area,type) {

    if (component == null)
       component = Qt.createComponent("./Tile.qml");


    if (component.status == Component.Ready) {
        var dynamicObject = component.createObject(area);
        if (dynamicObject == null) {
            console.log("error creating block");
            console.log(component.errorString());
            return false;
        }
        var blockSizex = area.width /50.7;
        var blockSizey = area.width /50.7;


        dynamicObject.x =(column * blockSizex);
        dynamicObject.y =(row * blockSizey);

        dynamicObject.width = blockSizex * 1.0;
        dynamicObject.height = blockSizey *1.0;

        dynamicObject.num = num;
        dynamicObject.row = row;
        dynamicObject.column = column;
        dynamicObject.cw_tile = 0;
        dynamicObject.cf_tile = 0;
        dynamicObject.base_tile = 0;

       tiles[num] = dynamicObject;




    } else {
        console.log("error loading block component");
        console.log(component.errorString());
        return false;
    }

    return true;
}

function create_E_Block(column,row, num,area,type) {

    if (ecomponent == null)

       ecomponent = Qt.createComponent("./E-Tile.qml");


    if (ecomponent.status == Component.Ready) {
        var dynamicObject = ecomponent.createObject(area);
        if (dynamicObject == null) {
            console.log("error creating block");
            console.log(ecomponent.errorString());
            return false;
        }
        var blockSizex = area.width /50.7;
        var blockSizey = area.width /50.7;


        dynamicObject.x =(column * blockSizex);
        dynamicObject.y =(row * blockSizey);

        dynamicObject.width = blockSizex * 1.0;
        dynamicObject.height = blockSizey *1.0;

        dynamicObject.num = num;
        dynamicObject.row = row;
        dynamicObject.column = column;
        dynamicObject.cw_tile = 0;
        dynamicObject.cf_tile = 0;
        dynamicObject.base_tile = 0;
        dynamicObject.size = 0;
        dynamicObject.anchor = 1;


       etiles[num] = dynamicObject;



    } else {
        console.log("error loading block component");
        console.log(ecomponent.errorString());
        return false;
    }

    return true;
}



function save_map() {
    //console.log("Running Auto Save");
    var num = 0;
    var mapdata;
    var enemymap;

    ///var mapdata =num+";"+tiles[num].cf_tile+";"+tiles[num].cw_tile+";"+tiles[num].base_tile+",";
    while (num < maxIndex) {

       mapdata = mapdata+num+";"+tiles[num].cf_tile+";"+tiles[num].cw_tile+";"+tiles[num].base_tile+",";
        enemymap = enemymap+num+";"+etiles[num].cf_tile+";"+etiles[num].cw_tile+";"+etiles[num].base_tile+";"+etiles[num].size+";"+etiles[num].anchor+",";
        num = num + 1;
    }

    var db = Sql.LocalStorage.openDatabaseSync("Adventures", "1.0", "Story", 1);

    var charactermap;
    var itemmap;
    var exitmap;
    var data;


    if(maptitle != " " && storyid != " ") {

    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS MAPS (id TEXT,storyid TEXT,mapid TEXT,title TEXT,discription TEXT,mapdata TEXT,enemymap TEXT,itemmap TEXT,charactermap TEXT,exitmap TEXT)');

        var storyString = "SELECT  *  FROM MAPS WHERE storyid='"+storyid+"'";
        var testStr = "SELECT  *  FROM MAPS WHERE mapid='"+mapid+"'";

        var spull = tx.executeSql(storyString);

        var mapnum =spull.rows.length+1;

        var pull =  tx.executeSql(testStr);
        var itemnum = 0;

        if(pull.rows.length == 0) {

             mapid = storyid+"_"+pull.rows.length+mapnum;

                console.log("Creating new map "+mapid);
            var insert = "INSERT INTO MAPS VALUES(?,?,?,?,?,?,?,?,?,?)";
            data = [id,storyid,mapid,maptitle.replace(/\'/g,"&#x27;"),mapdiscription.replace(/\'/g,"&#x27;"),mapdata,enemymap,itemmap,charactermap,exitmap];

              tx.executeSql(insert,data);

         } else {
                console.log("Updating map "+mapid);
            var updateMap = "UPDATE MAPS SET title='"+maptitle.replace(/\'/g,"&#x27;")+"',discription='"+mapdiscription.replace(/\'/g,"&#x27;")+"',mapdata='"+mapdata+"',enemymap='"+enemymap+"',charactermap='"+charactermap+"',itemmap='"+itemmap+"',exitmap='"+exitmap+"' WHERE mapid='"+mapid+"'";
           tx.executeSql(updateMap);



        }




        });

    }
}


function load_map(map) {

    var db = Sql.LocalStorage.openDatabaseSync("Adventures", "1.0", "Story", 1);

    mapid = map;

    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS MAPS (id TEXT,storyid TEXT,mapid TEXT,title TEXT,discription TEXT,mapdata TEXT,enemymap TEXT,itemmap TEXT,charactermap TEXT,exitmap TEXT)');

        var testStr = "SELECT  *  FROM MAPS WHERE mapid='"+map+"'";

        var pull =  tx.executeSql(testStr);
        var itemnum = 0;

        if(pull.rows.length == 1) {
          //  console.log("Loading Map for location "+maptitle);

            maptitle = pull.rows.item(0).title.replace(/\&#x27;/g,"'");
            mapdiscription = pull.rows.item(0).discription.replace(/\&#x27;/g,"'");

            var griddata = pull.rows.item(0).mapdata;
            var enemydata = pull.rows.item(0).enemymap;

            fillmap(griddata,"base");
            fillmap(enemydata,"enemy");


        } else {
            console.log("NEW MAP!!!");
        }


        });


}


function fillmap(griddata,layer) {

    var placement = griddata.split(",");
    var num = 1;


  switch (layer) {
    case "base":while(num < maxIndex) {
        tiles[num].cf_tile = placement[num].split(";")[1];
        tiles[num].cw_tile =placement[num].split(";")[2];
        tiles[num].base_tile = placement[num].split(";")[3];


        num = num + 1;
    }break;
    case "enemy":while(num < maxIndex) {
        etiles[num].cf_tile = placement[num].split(";")[1];
        etiles[num].cw_tile =placement[num].split(";")[2];
        etiles[num].base_tile = placement[num].split(";")[3];
        etiles[num].size = placement[num].split(";")[4];
        etiles[num].anchor = placement[num].split(";")[5];


        num = num + 1;
    }break;
    case "items":while(num < maxIndex) {
        itiles[num].cf_tile = placement[num].split(";")[1];
        itiles[num].cw_tile =placement[num].split(";")[2];
        itiles[num].base_tile = placement[num].split(";")[3];


        num = num + 1;
    }break;
    case "exits":while(num < maxIndex) {
        extiles[num].cf_tile = placement[num].split(";")[1];
        extiles[num].cw_tile =placement[num].split(";")[2];
        extiles[num].base_tile = placement[num].split(";")[3];


        num = num + 1;
    }break;

  }

}



function clearmap() {

    var num = 0;

    maptitle = " ";
    mapdiscription = " ";
    mapid = " ";


    while (num < maxIndex) {

       tiles[num].cw_tile = 0;
        tiles[num].cf_tile = 0;
        tiles[num].base_tile = 0;

        //etiles[num].cw_tile = 0;
        // etiles[num].cf_tile = 0;
        // etiles[num].base_tile = 0;

       // itiles[num].cw_tile = 0;
        // itiles[num].cf_tile = 0;
        // itiles[num].base_tile = 0;


        num = num + 1;
    }

}


function listmaps(story) {



    var db = Sql.LocalStorage.openDatabaseSync("Adventures", "1.0", "Story", 1);


    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS MAPS (id TEXT,storyid TEXT,mapid TEXT,title TEXT,discription TEXT,mapdata TEXT,enemymap TEXT,itemmap TEXT,charactermap TEXT,exitmap TEXT)');

        var testStr = "SELECT  *  FROM MAPS WHERE storyid='"+story+"'";

        var pull =  tx.executeSql(testStr);
        var itemnum = 0;

        while (itemnum < pull.rows.length) {

                maplist.append ({

                                    name:(itemnum+1)+"."+pull.rows.item(itemnum).title,
                                    thestory:pull.rows.item(itemnum).storyid,
                                    themap:pull.rows.item(itemnum).mapid
                                });



            itemnum = itemnum + 1;
        }

        });





}


function autowall() {
    var num = 0;

    while(num < maxIndex) {

        if((num+maxRow) <maxIndex) {

            if(tiles[num+maxRow].cw_tile == 1) {
                if(tiles[num+1].cw_tile == 1) {
                        if(tiles[num].cw_tile == 1 || tiles[num].cw_tile == 7) {
                            tiles[num].cw_tile = 7;
                        } else {
                            tiles[num].cw_tile = 11;
                        }
                        tiles[num+maxRow].cw_tile =3;
                    }

                if(tiles[num-1].cw_tile == 1) {
                    if(tiles[num].cw_tile == 1 || tiles[num].cw_tile == 10) {
                        tiles[num].cw_tile = 10;
                    } else {
                        tiles[num].cw_tile = 12;
                    }
                    tiles[num+maxRow].cw_tile =4;
                }

                if(tiles[num-1].cw_tile != 1 && tiles[num+1].cw_tile != 1) {
                    if(tiles[num].cw_tile == 1) {
                        if((num-maxRow) > 0) {
                        if(tiles[num-maxRow].cw_tile == 4 || tiles[num-maxRow].cw_tile == 10) {
                                tiles[num].cw_tile = 4;
                        } else {
                            tiles[num].cw_tile = 3;
                        }
                                }
                    }
                }

    }

        if(tiles[num+maxRow].cw_tile == 4) {

            if(tiles[num+1].cw_tile == 1) {
                    if(tiles[num].cw_tile == 1 || tiles[num].cw_tile == 7) {
                        tiles[num].cw_tile = 9;
                    } else {
                        //tiles[num].cw_tile = 12;
                    }
                    tiles[num+maxRow].cw_tile =3;
                }

            if(tiles[num+(maxRow+1)].cw_tile == 1) {
                        tiles[num].cw_tile = 10;
            }


        }



    }




    num = num + 1;
    }
}

function monsterSize(size,num) {

        clear_highlight();
    switch(size) {
    case 1: etiles[num].base_tile = 1;break;
    case 2: etiles[num].base_tile = 1;etiles[num+1].base_tile = 1;etiles[num+maxColumn].base_tile = 1;etiles[num+maxColumn+1].base_tile = 1;break;
    case 3: etiles[num].base_tile = 1;etiles[num+1].base_tile = 1;etiles[num+maxColumn].base_tile = 1;etiles[num+maxColumn+1].base_tile = 1;
            etiles[num+2].base_tile = 1;etiles[num+maxColumn*2].base_tile = 1;etiles[num+maxColumn+2].base_tile = 1;
            etiles[num+maxColumn*2+1].base_tile = 1;etiles[num+maxColumn*2+2].base_tile = 1;break;
    case 4: etiles[num].base_tile = 1;etiles[num+1].base_tile = 1;etiles[num+maxColumn].base_tile = 1;etiles[num+maxColumn+1].base_tile = 1;
            etiles[num+2].base_tile = 1;etiles[num+maxColumn*2].base_tile = 1;etiles[num+maxColumn+2].base_tile = 1;
            etiles[num+maxColumn*2+1].base_tile = 1;etiles[num+maxColumn*2+2].base_tile = 1;etiles[num+maxColumn*2+3].base_tile = 1;
            etiles[num+3].base_tile = 1;etiles[num+maxColumn*3].base_tile = 1;etiles[num+maxColumn+3].base_tile = 1;
            etiles[num+maxColumn*3+2].base_tile = 1;etiles[num+maxColumn*3+3].base_tile = 1;etiles[num+maxColumn*3+1].base_tile = 1;

                break;

    case 6: etiles[num].base_tile = 1;for(var down=0;down < 6;down++) {
                                            for(var across = 0;across < 6;across++) {
                                                etiles[num+down+maxColumn*across].base_tile = 1;}
                                        }break;

    }

}

function clear_highlight() {
    var num = 0;
    while (num < maxIndex) {
        etiles[num].base_tile = 0;
        num = num + 1;
    }
}


// codex functions

function codex(type,search) {

    codexlist.clear();

    var db = Sql.LocalStorage.openDatabaseSync("Codex", "1.0", "Story", 1);
    var testStr;

    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS EQUIP (name TEXT,cost TEXT,Weight INT(11),Maxium INT,discription TEXT,type INT(11))');
        tx.executeSql('CREATE TABLE IF NOT EXISTS ARMOR (name TEXT,dmgS TEXT,dmgM TEXT,dmgL TEXT,AB INT(11),Dex INT(11),ACP INT(11),ASFC DOUBLE(11,2),Crit INT(11),Weight INT(11),Speed30P TEXT,Speed20P TEXT,dtype TEXT,Special TEXT,cost TEXT,discription TEXT,type INT(11))');
        tx.executeSql('CREATE TABLE IF NOT EXISTS WEAPONS (name TEXT,dmgS TEXT,dmgM TEXT,dmgL TEXT,Crit INT(11),Range INT(11),Weight INT(11),dtype TEXT,Special TEXT,cost TEXT,WeaponType TEXT,discription TEXT,mtype INT(11),stype INT(11))');


            switch(type) {

            case "equip":testStr = "SELECT  *  FROM EQUIP WHERE 1";lvlsneeded = false;break;
            case  "armor":testStr= "SELECT  *  FROM ARMOR WHERE 1";lvlsneeded = false;break;
            case  "weapons":testStr= "SELECT  *  FROM WEAPONS WHERE 1";lvlsneeded = false;break;
            default:break;
         }

        var pull =  tx.executeSql(testStr);
        var itemnum = 0;

        while (itemnum < pull.rows.length) {

            var thetype = " ";

            if(pull.rows.item(itemnum).type != undefined) {
            thetype = pull.rows.item(itemnum).type
                    }

                codexlist.append ({

                                    name:pull.rows.item(itemnum).name,
                                    cdiscription:pull.rows.item(itemnum).discription,
                                    cindex:itemnum,

                                    itemtype:thetype
                                });



            itemnum = itemnum + 1;
        }

        });




}

function codex_article(type,thingid) {


    var db = Sql.LocalStorage.openDatabaseSync("Codex", "1.0", "Story", 1);

     var testStr;
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS EQUIP (name TEXT,cost TEXT,Weight INT(11),Maxium INT,discription TEXT,type INT(11))');
        tx.executeSql('CREATE TABLE IF NOT EXISTS ARMOR (name TEXT,dmgS TEXT,dmgM TEXT,dmgL TEXT,AB INT(11),Dex INT(11),ACP INT(11),ASFC DOUBLE(11,2),Crit INT(11),Weight INT(11),Speed30P TEXT,Speed20P TEXT,dtype TEXT,Special TEXT,cost TEXT,discription TEXT,type INT(11))');
        tx.executeSql('CREATE TABLE IF NOT EXISTS WEAPONS (name TEXT,dmgS TEXT,dmgM TEXT,dmgL TEXT,Crit INT(11),Range INT(11),Weight INT(11),dtype TEXT,Special TEXT,cost TEXT,WeaponType TEXT,discription TEXT,mtype INT(11),stype INT(11))');


        switch(type) {
        case "equip":testStr = "SELECT  *  FROM EQUIP WHERE 1";break;
        case "armor":testStr = "SELECT  *  FROM ARMOR WHERE 1";break;
        case "weapons":testStr = "SELECT  *  FROM WEAPONS WHERE 1";break;
        case "spells":testStr = "SELECT  *  FROM SPELLS WHERE 1";break;
        default:break;
        }

        var pull =  tx.executeSql(testStr);

        item_discription ="<b>Discription:</b>\n"+pull.rows.item(thingid).discription
        switch(type) {
        case "equip":item_stats = "Cost: "+pull.rows.item(thingid).cost+"\n\nWeight: "+pull.rows.item(thingid).Weight;break;
        case "armor":item_stats = "Cost: "+pull.rows.item(thingid).cost+"\n\nWeight: "+pull.rows.item(thingid).Weight+" | Speed Penalty: "+pull.rows.item(thingid).Speed30P+"\n"+
                     "\nArmor Bonus:"+pull.rows.item(thingid).AB+" | Dex Penatiy: "+pull.rows.item(thingid).Dex+" | AC Penalty: "
                     +pull.rows.item(thingid).ACP+" | Arcane Spell faliure Chance: "+pull.rows.item(thingid).ASFC+"%\n"


            ;break;
        case "weapons":item_stats = "Cost: "+pull.rows.item(thingid).cost+"\n\nWeight: "+pull.rows.item(thingid).Weight+" | Range: "+pull.rows.item(thingid).Range+"\n"+
                     "\nWeapon Type:"+pull.rows.item(thingid).weapontype


            ;break;
        case "spells":item_stats = "Cost: "+pull.rows.item(thingid).cost+"\n\nWeight: "+pull.rows.item(thingid).Weight+" | Speed Penalty: "+pull.rows.item(thingid).Speed30P+"\n"+
                     "\nArmor Bonus:"+pull.rows.item(thingid).AB+" | Dex Penatiy: "+pull.rows.item(thingid).Dex+" | AC Penalty: "
                     +pull.rows.item(thingid).ACP+" | Arcane Spell faliure Chance: "+pull.rows.item(thingid).ASFC+"%\n"


            ;break;
        }

        });


}
