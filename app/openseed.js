
function oseed_auth(name,email) {

    var http = new XMLHttpRequest();
    //var url = "http://openseed.vagueentertainment.com/corescripts/auth.php?devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email ;
    var url = "http://openseed.vagueentertainment.com/corescripts/authPOST.php";
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
              //  console.log(http.responseText);
                id = http.responseText;
                createdb();
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email);
}

function createdb() {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);
    var userStr = "INSERT INTO USER VALUES(?,?)";

    var data = [id,username];

    var testStr = "SELECT  *  FROM USER WHERE id= '"+id+"'";

        db.transaction(function(tx) {
          //tx.executeSql("DROP TABLE USER");
            tx.executeSql('CREATE TABLE IF NOT EXISTS USER (id TEXT, name TEXT)');


                        var test = tx.executeSql(testStr);


                            if(test.rows.length == 0) {

                                tx.executeSql(userStr, data);
                            } else {

                            //tx.executeSql(updateUser);
                                }



        });

}

function heartbeat() {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/corescripts/heartbeat.php";
   // console.log(url)

    http.onreadystatechange = function() {

       if(http.status == 200) {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {

                heart = http.responseText;
                updateinterval = 20000;

            }

        }
            } else {
                    heart = "Offline";
                    updateinterval = 2000;

        }
    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&userid="+ id);

    heartbeats.interval = updateinterval;
    heartbeats.repeat = true;

}

function check_commissions() {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/"+devId+"/"+appId+"/scripts/commissions.php";
   //console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
              //  console.log(http.responseText);

            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("userid="+ id);


}

function retrieve_commissions() {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/"+devId+"/"+appId+"/scripts/commissions.php";
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
              //  console.log(http.responseText);


            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email);


}

function check_gallery() {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/"+devId+"/"+appId+"/scripts/gallery.php";
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
               console.log(http.responseText);


            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ id + "&type=check" );


}

function retrieve_gallery() {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/"+devId+"/"+appId+"/scripts/gallery.php";
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
              //  console.log(http.responseText);

                //createdb();
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ id + "&type=retrieve" );

}

function send_gallery(image) {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/"+devId+"/"+appId+"/scripts/gallery.php";
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
              //  console.log(http.responseText);

                //createdb();
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("&id="+ id + "&image=" + image + "&type=update" );


}

function retrieve_info() {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/"+devId+"/"+appId+"/scripts/info.php";
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                console.log(http.responseText);

                //createdb();
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ id + "&type=retrieve" );

}

function send_info() {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/"+devId+"/"+appId+"/scripts/info.php";
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
            // console.log(http.responseText);

                //createdb();
                send_images("artist","avatar",avatarimg);
                send_images("artist","sample",avatarimg);
                changes = 0;
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ id + "&storename="+ storename.replace(/\'/g,"&#x27;") + "&artistname="+ artistname.replace(/\'/g,"&#x27;") + "&discription="+ discription.replace(/\'/g,"&#x27;") + "&contact="+ contact + "&pub="+ pub + "&donations="+ donations +"&commissions="+ commissions + "&paypal="+ paypal +"&patreon="+ patreon + "&coinbase="+ coinbase +"&type=sending" );

}

function send_images(where,type,image) {

    var http = new XMLHttpRequest();
    var url = "";
    var imagedata = "";
    fileio.send = type+","+image;
    imagedata = fileio.send;

        if(where == "artist") {
        url = "http://openseed.vagueentertainment.com/devs/"+devId+"/"+appId+"/scripts/info-images.php";
        }

   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                //console.log(http.responseText);


            }

        }
    }
    http.open('POST', url.trim(), true);

   http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("id="+id+"&type="+type+"&imagename="+image+"&imagedata="+imagedata);

}


function codex(base) {




    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/"+devId+"/"+appId+"/scripts/codex.php";

    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);

            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                //console.log(http.responseText);

                var sitereturn = http.responseText

                if(base == "armor") {

                    var db = Sql.LocalStorage.openDatabaseSync("Codex", "1.0", "Local Codex", 1);
                    var userStr = "INSERT INTO ARMOR VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";


                        var items = sitereturn.split("begin::");

                        for(var itemnum = 1;itemnum < items.length;itemnum++) {
                            var name = items[itemnum].split(";&;")[0];
                            var dmgS = items[itemnum].split(";&;")[1];
                            var dmgM = items[itemnum].split(";&;")[2];
                            var dmgL = items[itemnum].split(";&;")[3];
                            var AB = items[itemnum].split(";&;")[4];
                            var Dex = items[itemnum].split(";&;")[5];
                            var ACP = items[itemnum].split(";&;")[6];
                            var ASFC = items[itemnum].split(";&;")[7];
                            var Crit = items[itemnum].split(";&;")[8];
                            var Weight = items[itemnum].split(";&;")[9];
                            var Speed30P = items[itemnum].split(";&;")[10];
                            var Speed20P = items[itemnum].split(";&;")[11];
                            var dtype = items[itemnum].split(";&;")[12];
                            var Special = items[itemnum].split(";&;")[13];
                            var cost = items[itemnum].split(";&;")[14];
                            var discription = items[itemnum].split(";&;")[15];
                            var type = items[itemnum].split(";&;")[16];



                        var data =[name.replace(/\'/g,"&#x27;"),dmgS,dmgM,dmgL,AB,Dex,ACP,ASFC,Crit,Weight,Speed30P,Speed20P,dtype,Special,cost,discription.replace(/\'/g,"&#x27;"),type];




                    var testStr = "SELECT  *  FROM ARMOR WHERE name= '"+name+"'";

                        db.transaction(function(tx) {

                            tx.executeSql('CREATE TABLE IF NOT EXISTS ARMOR (name TEXT,dmgS TEXT,dmgM TEXT,dmgL TEXT,AB INT(11),Dex INT(11),ACP INT(11),ASFC DOUBLE(11,2),Crit INT(11),Weight INT(11),Speed30P TEXT,Speed20P TEXT,dtype TEXT,Special TEXT,cost TEXT,discription TEXT,type INT(11))');


                                        var test = tx.executeSql(testStr);


                                            if(test.rows.length == 0) {

                                                tx.executeSql(userStr, data);
                                            } else {

                                            //tx.executeSql(updateUser);
                                                }



                        });


                        }

                }


                if(base == "equip") {

                    var db = Sql.LocalStorage.openDatabaseSync("Codex", "1.0", "Local Codex", 1);
                    var userStr = "INSERT INTO EQUIP VALUES(?,?,?,?,?,?)";


                        var items = sitereturn.split("begin::");

                        for(var itemnum = 1;itemnum < items.length;itemnum++) {
                            var name = items[itemnum].split(";&;")[0];
                            var cost = items[itemnum].split(";&;")[1];
                            var Weight = items[itemnum].split(";&;")[2];
                            var Maxium = items[itemnum].split(";&;")[3];
                            var discription = items[itemnum].split(";&;")[4];
                            var type = items[itemnum].split(";&;")[5];



                        var data =[name.replace(/\'/g,"&#x27;"),cost,Weight,Maxium,discription.replace(/\'/g,"&#x27;"),type];




                    var testStr = "SELECT  *  FROM ARMOR WHERE name= '"+name+"'";

                        db.transaction(function(tx) {

                            tx.executeSql('CREATE TABLE IF NOT EXISTS EQUIP (name TEXT,cost TEXT,Weight INT(11),Maxium INT,discription TEXT,type INT(11))');


                                        var test = tx.executeSql(testStr);


                                            if(test.rows.length == 0) {

                                                tx.executeSql(userStr, data);
                                            } else {

                                            //tx.executeSql(updateUser);
                                                }



                        });


                        }

                }







            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("id="+ id + "&type="+base );


}
