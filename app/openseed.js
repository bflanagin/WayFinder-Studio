
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
