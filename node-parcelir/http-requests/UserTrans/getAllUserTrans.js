const express = require("express");
const alltransRouter = express.Router();
const mysqlConnection = require("../../connect-db/connections");


alltransRouter.post("/transactions",(req,res)=>{
  var contact = req.query.contact

  
console.log(`Getting Lessongs`);


  var query1 = `SELECT * FROM ItemsData WHERE smobile = '${contact}' OR rmobile = '${contact}' Order By delivid Desc`;
  var query2 = `SELECT * FROM ItemsData Order By delivid Desc`;
  mysqlConnection.query(
    contact == null?query2:query1,
    //`SELECT * FROM Lessons WHERE courseid = '${courseid}'`,
      (err,rows,cols)=>{
         if(!err){
           res.json(rows);
           //res.json("Registration Failed");
           console.log(err);
         }

  });


});

module.exports = alltransRouter
