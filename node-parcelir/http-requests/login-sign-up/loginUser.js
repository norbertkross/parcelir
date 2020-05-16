const express = require("express");
const loginRouter = express.Router();
const mysqlConnection = require("../../connect-db/connections");


loginRouter.post("/login",(req,res,err)=>{
  // Get Names From The Requested Data In Post

  var email = req.query.email
  var password = req.query.password


  console.log(password);


  mysqlConnection.query(`SELECT * FROM Users WHERE email = '${email}' AND password = '${password}'`,
      (err,rows,cols)=>{
         if(!err){
           console.log("before rows pass");
           // var pasRes = rows[0].userid;
           //  console.log(`userid: ${rows[0].userid}  length ${rows.length }`);
           if(rows.length == 1 ){

             var userid = rows[0].userid;
             // *703# 0277783408
//Insert The User Computer Details Into UserComputer Table
//REPLACE INTO usercomputer(computerid,userid) VALUES ('aberorsID Giberish','4')


             res.json(rows);

           }else{
             console.log(err);
             res.json("An Error Occured");
           }
         }
         else {
           console.log(err);
           res.json("Un Expected Error Occured");
         }

  });


});


module.exports = loginRouter
