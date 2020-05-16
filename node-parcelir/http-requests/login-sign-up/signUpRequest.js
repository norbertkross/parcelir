const express = require("express");
const signUpRouter = express.Router();
const mysqlConnection = require("../../connect-db/connections");
const moment = require("moment");

signUpRouter.post("/register",(req,res,err)=>{




  // Get Names From The Requested Data In Post
  var name = req.query.name
  var email = req.query.email
  var password = req.query.password
  var phonenumber = req.query.phonenumber

  console.log(req.query);



 mysqlConnection.query(`SELECT COUNT(1) AS UserExist FROM users WHERE email = "${email}"`,
 (err,rows,cols)=>{


// Very the email to know a user already Exists with such email
       if(!err){
           //res.send(rows);
           var alreadyExists = rows[0].UserExist;
           if( alreadyExists>0 ){

             res.json("User already Exists");
             console.log(alreadyExists);

           }else{
             console.log(alreadyExists);

// Add new user if the user does not Exists

// Parser Error if no Single Quotes around variable putting single quotes around your values, so you're doubling that up by adding them yourself
                 mysqlConnection.query(`INSERT INTO Users (name, email, password, phonenumber) VALUES ("${name}", "${email}", '${password}','${phonenumber}')`,
                 (err,rows,fields)=>{
                     if(!err){
                       console.log("This Is The Error logs [\n" +err +"\n]");
                         res.json("Registration Succeeded");
                     }else{
                         console.log("This Is The Error logs [\n" +err +"\n]");
                         res.json("Registration Failed");
                     }
                 });
           }

       }else{
           console.log("This Is The Error logs [\n" +err +"\n]");
           res.json("Registration Failed");
       }

 });


  });

module.exports = signUpRouter
