const express = require("express");
const recieveDeliveryRouter = express.Router();
const mysqlConnection = require("../../connect-db/connections");
const moment = require("moment");
var multer  = require('multer')
var upload = multer({ dest: 'uploads/' })
var fs = require('fs');
var multer = require('multer')



recieveDeliveryRouter.post("/recieveDelivery", upload.single("picture"), function (req,res){

  // Random Variable To Attach To File Names
var randName = Math.floor(Math.random() * 199897864369799990);
    
var time = moment().utc().format('HH:mm:ss')
var date = moment().format('YYYY-MM-DD')

var filename = req.file.originalname;
var endFile = "http://10.0.2.2:5000"+"/art-head/"+ randName+'-'+filename
console.log(`MY FILE NAME: ${filename}`)
//senderName, reciepientName,smobile,rmobile,destination,itemName,itemsCost,itemspic,rName,rNumber,payOnDelivery,userid ,
//     console.log(`

// sname    ${req.query.senderName}
// reciep   ${req.query.reciepientName}
// smobile  ${req.query.smobile}
// rmobile  ${req.query.rmobile}
// dest     ${req.query.destination}
// itmName  ${req.query.itemName}
// cost     ${req.query.itemsCost}
// pic      ${req.query.itemspic}
// deli     ${req.query.payOnDelivery}
//     `);

  // Get Names From The Requested Data In Post

  var payOnDelivery = req.query.payOnDelivery
  var isDelivered = req.query.isDelivered
  var theId = req.query.theId
//   var userid = req.query.userid




// Add new user if the user does not Exists
//senderName, reciepientName,smobile,rmobile,destination,itemName,itemsCost,itemspic, rName,rNumber,payOnDelivery,           userid ,
 
// Parser Error if no Single Quotes around variable putting single quotes around your values, so you're doubling that up by adding them yourself


imgUpload(req,randName).then((state)=>{
  if (state == "OK") {
    console.log("yES oK");

    // Insert Items Into DataBase After Image Upload

    mysqlConnection.query(`UPDATE ItemsData set payOnDelivery="${payOnDelivery}",isDelivered="${isDelivered}",recieverPicture="${endFile}" WHERE delivid=${theId}`,
    (err,rows,fields)=>{
        if(!err){

           res.json("Registration Succeeded");
        }else{
            console.log("This Is The Error logs [\n" + err +"\n]");
            res.json("Registration Failed");
        }
    });    


  }else{
    res.json("Could Not Upload Image")
  }
});
   


  });



  var imgUpload = function(req,randName){
    return new Promise((resolve,reject)=>{
      // The Value "Picture" in upload type upload.single("picture") is the parameter in the post request
      console.log("inside Upload Image Method");
        console.log("Received file" +randName+'-'+ req.file.originalname);
        var src = fs.createReadStream(req.file.path);
        var dest = fs.createWriteStream('uploads/' +randName+'-'+ req.file.originalname);
        src.pipe(dest);
        src.on('end', function() {
          fs.unlinkSync(req.file.path);
  
          //res.json('OK: received ' + req.file.originalname);
          resolve("OK")
        });
        src.on('error', function(err) { res.json('Something went wrong!'); });
        //reject("NO")
    });
  }



module.exports = recieveDeliveryRouter
