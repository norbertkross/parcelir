import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parcelir/reuse/giveStatic.dart';
import 'package:parcelir/scrns/Dialoges/myDiaoge.dart';
import 'package:parcelir/scrns/mytransac.dart';
import 'package:parcelir/serveGlobal/serveglobal.dart';
import 'package:parcelir/reuse/giveStatic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginBody extends StatefulWidget {
  final bool isAdmin;
  LoginBody({this.isAdmin,Key key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

String get emailCon => _emailController.text;
String get passCon => _passwordController.text;

  bool keepMeInn = true;
  bool obscured = true;


bool isLoading = false;
String baseUrl = GiveStatic.baseOfUrl;
String return_msg_to_show = "";


  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

// LOGIN THE USER
          loginUser()async{
            print("The IsAdmin: ${widget.isAdmin}");
// print("The Key TO Send: $theKey");
          String apiUrl ="$baseUrl/${widget.isAdmin != null?"loginAdmin":"login"}?email=${emailCon.trim()}&password=${passCon.trim()}";
          List responseBody ;
          // print("Loading ......");
          try{
          setState(() {
            isLoading = true;
          });


          var resp = await http.post(Uri.encodeFull(apiUrl),
          //body: postData
          headers: {
          "Accept":"application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
            });
          // print("before response");
            if (resp.statusCode == 200){ 
                // print("status code");

                if(resp.body != null){
                  // print("not null");
                responseBody = jsonDecode(resp.body);
                // print("results \n::$responseBody");
                setState(() {
                  isLoading = false;
                return_msg_to_show = responseBody.length == 0?"INCORRECT CREDENTIALS":"LOGIN SUCCESSFUL";
                  // print("The Length of the list: ${responseBody.length}");
                });
                if(responseBody.length > 0 ){
                  if(widget.isAdmin != null){
                    SharedPreferences prefs = await _prefs;
                     prefs.setString('iamadmin',"yes") ;
                  }
                  print("Logged In Successfully");
                }
                }else{
                  setState(() {
                    isLoading = false;
                    return_msg_to_show ="login failed !";
                  });        
                }
            } else { 
                  setState(() {
                    isLoading = false;
                    return_msg_to_show ="login failed !";
                  });
            } 

          }catch(e){
          setState(() {
            isLoading = false;
            return_msg_to_show ="login failed !";
          });
          print(e);
          print("Exeption Thrown");
          }

          return responseBody;
          }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
         child:                Column(
                   children: <Widget>[
                    //  SizedBox(
                    //    height: 20,
                    //  ),
                     SizedBox(
                       height:MediaQuery.of(context).orientation == 
                       Orientation.landscape?50:100,
                       width: 100,
                       child: 
                       CircleAvatar(
                         backgroundColor: Colors.red.withOpacity(.0),
                      child: 
                       ClipRRect(
                         borderRadius: BorderRadius.circular(200),
                         child: Image.asset("${ServeGlobal.imgUrl}"),
                         ),
                         ),
                       ),

                      //  SizedBox(
                      //    height: 50,
                      //  ),
      Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(   
        controller: _emailController, 
      decoration: InputDecoration(labelText: '    email   ',
 border: OutlineInputBorder(
      borderSide: BorderSide(
       color: Colors.red, 
        width: 5.0),
        ),
      ),
      ),
  ),
SizedBox(height: 10,),

      Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(  
        controller: _passwordController,
        obscureText: obscured,  
      decoration: InputDecoration(labelText: 'password',
      suffixIcon: GestureDetector(
        onTap: (){
          setState(() {
            obscured = !obscured;
          });
        },
              child: obscured == true? Icon(Icons.visibility_off,color: Colors.white,) : Icon(Icons.visibility,color: Colors.white,) ,

      ),    
 border: OutlineInputBorder(
      borderSide: BorderSide(
       color: Colors.red, 
        width: 5.0),
        ),
      ),
      ),
  ),
SizedBox(height: 30,), 
widget.isAdmin == null? Table(children: [
  TableRow(children: [
      Checkbox(value: keepMeInn,checkColor: Colors.red,activeColor: Colors.white, onChanged: (retVal){
        setState(() {
          keepMeInn = retVal;
        });
      }),
      Text("\nRemember me",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
  ]),

]):Container(),
SizedBox(height: 30,),

            CupertinoButton(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              child: isLoading == true? CircularProgressIndicator():
               Text(" Login    "
              ,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
              ), onPressed: (){

                  if(emailCon.isNotEmpty && passCon.isNotEmpty){
                   
                    // print("showing indicator");
                   setState(() {
                      isLoading = !isLoading;
                   });
                    loginUser().then((repsRes)async{

// print("The Response $repsRes");
                      if(repsRes == null){

                Navigator.of(context).push(
                PageRouteBuilder( opaque: false,pageBuilder: (BuildContext context,___, __){
                          return BaseAlertDialog(
                            yes: "OK",
                            content: "$return_msg_to_show",
                            noOnPressed: (){Navigator.pop(context);},
                            title: "@ Login",
                            yesOnPressed: (){Navigator.pop(context);},
                          );
                        }                      
                  ));
                      }else{
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyItems()));

                      }
                    });
                   //return_msg_to_show ="Something went wrong";
                  }else{


                  Navigator.of(context).push(
                PageRouteBuilder( opaque: false,pageBuilder: (BuildContext context,___, __){
                          return BaseAlertDialog(
                            yes: "OK",
                            content: "${passCon.isEmpty || emailCon.isEmpty? "Please fill all fields.":""}\n${passCon.isNotEmpty && passCon.length < 6? "Password should be six(6) or more ":""}",
                            noOnPressed: (){},
                            title: "@from Parcelir",
                            yesOnPressed: (){Navigator.pop(context);},
                          );
                        }                      
                  ));
                  }


              }),
SizedBox(height: 20,),
            widget.isAdmin == null?  GestureDetector(onTap: (){},
              child: Text("Forgot password?",
              style: TextStyle(color: Colors.white,))):Container(),
                   ],
                 ),
      ),
    );
  }
}