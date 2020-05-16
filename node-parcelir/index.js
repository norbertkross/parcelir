var express = require('express')
var app = express()
const http = require('http').createServer(app)
var cors = require('cors')

const register = require('./http-requests/login-sign-up/signUpRequest')
const login = require('./http-requests/login-sign-up/loginUser')
const adminlogin = require('./http-requests/login-sign-up/loginAdmin')


app.use(cors())
app.get('/', (req, res,err) => {
    res.send("<h1>THIS IS PARCELIR HOMEPAGE")
    //res.sendFile(__dirname + '/website/index.html');
  });



  // Route to use when the requested route is not found on server
  app.get('*', function(req, res){
    res.status(404).send(' Resource Not Found ');
  });


  // My Defined  File Routes
        app.use(register);

        app.use(login)
        
        app.use(adminlogin)




  const myhost = process.env.HOST || 'localhost'
  // connect With HTTP and listen On Port 3000 or Available PORT
      http.listen(
        process.env.PORT || 5000,myhost,()=>{
        console.log("running on port 5000");
      })
