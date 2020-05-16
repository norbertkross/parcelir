import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parcelir/reuse/giveStatic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:parcelir/scrns/Dialoges/myDiaoge.dart';
//## this is the body of the registrantion for the front page
class RegisterBody extends StatefulWidget {
  RegisterBody({Key key}) : super(key: key);

  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _nameController = TextEditingController();
TextEditingController _phonenumerController = TextEditingController();

String get emailCon => _emailController.text;
String get passCon => _passwordController.text;
String get nameCon => _nameController.text;
String get phonenumber => _phonenumerController.text;

bool isValidName = false;
bool isValidEmail = false;
bool obscured = true;

bool isLoading = false;
String baseUrl = GiveStatic.baseOfUrl;
String return_msg_to_show = "";

RegExp regExpMatch = 
RegExp(r"""(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])""");


changesOnField(){ 
    // print("Updated Text: $nameCon");
    if(
    nameCon.contains("@")||nameCon.contains("/")
    ||nameCon.contains(".")||nameCon.contains("?")
    ||nameCon.contains("\$")||nameCon.contains("%")
    ||nameCon.contains("^")||nameCon.contains("*")
    ||nameCon.contains("#")||nameCon.contains("(")
    ||nameCon.contains(")")||nameCon.contains("|")
    ||nameCon.contains("\\")||nameCon.contains("+")
    ||nameCon.contains("-")||nameCon.contains("(")
    ||nameCon.contains("&")
    ){
       isValidName = false; 
       }else{
         isValidName = true;
       }
    setState(() {}); // Will re-Trigger Build Method
  }

changesOn_Email_Field(){ 
    // print("Updated Text: $emailCon");
    if( !regExpMatch.hasMatch(emailCon)){
       isValidEmail = false; 
       }else{
         isValidEmail = true;
       }
    setState(() {});
    }




// SIGN UP THE USER
          signUpMethod()async{
 
          String apiUrl ="$baseUrl/register?name=${nameCon.trim()}&email=${emailCon.trim()}&password=${passCon.trim()}&phonenumber=$phonenumber";
          var responseBody ;

          try{
          setState(() {
            isLoading = true;
          });

          var resp = await http.post(Uri.encodeFull(apiUrl),
          //body: postData,
          headers: {
          "Accept":"application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
            
            });

            if (resp.statusCode == 200) { 
                // print("status code");

                if(resp.body != null){
                  // print("not null");
                responseBody = jsonDecode(resp.body);
                // print("results :: $responseBody");
                setState(() {
                  isLoading = false;
                return_msg_to_show = responseBody;
                });      
                }else{
                  setState(() {
                    isLoading = false;
                    return_msg_to_show ="Something went wrong";
                  });        
                  // print("The request gave null");
                }
            } else { 
              // print(resp.statusCode);
                  setState(() {
                    isLoading = false;
                    return_msg_to_show ="Something went wrong";
                  });     
                // print("should throw exception now");
                throw Exception('Unable to fetch products from the REST API');
            }


          }
          catch(e){
          setState(() {
            isLoading = false;
            return_msg_to_show ="Something went wrong";
          });
          }
          return responseBody;
          }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.addListener(changesOnField);
    _emailController.addListener(changesOn_Email_Field);    
  }


  @override
  Widget build(BuildContext context) {
    return Container(
       child:                Column(
                 children: <Widget>[

        SizedBox(
          height: 5,
        ),
    Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextField(  
      controller: _nameController,  
    decoration: InputDecoration(labelText: 'Full name',
   suffixIcon: isValidName == true? Icon(Icons.done,color: Colors.green,) : Icon(Icons.close,color: Colors.white,) ,
    prefixIcon: Icon(Icons.person),
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
      controller: _emailController,    
    decoration: InputDecoration(labelText: 'email',
    suffixIcon: GestureDetector(
      child: isValidEmail == true? Icon(Icons.done_all,color: Colors.green,) : Icon(Icons.close,color: Colors.white,) ,
    ),
    prefixIcon: Icon(Icons.alternate_email),
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
      controller: _phonenumerController,
    decoration: InputDecoration(labelText: 'number',
    prefixIcon: Icon(Icons.keyboard),
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
    prefixIcon: Icon(Icons.security),
 border: OutlineInputBorder(
    borderSide: BorderSide(
     color: Colors.red, 
      width: 5.0),
      ),
    ),
    ),
  ),
SizedBox(height: 30,),

          CupertinoButton(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            child: isLoading == true?CircularProgressIndicator(): Text("Register"
            ,style: TextStyle(color: Colors.red),
            ), onPressed: (){
              print("About TO MAke Request");
              if(emailCon.isNotEmpty && passCon.isNotEmpty && nameCon.isNotEmpty 
              && isValidEmail==true && isValidName==true && passCon.length >= 6){
                //signUpMethod();
                  setState(() {
                    isLoading = !isLoading;
                 });
                  signUpMethod().then((repsRes){
                    if(repsRes.toString() == "Registration Succeeded"){
                      setState((){
                      _nameController.clear();
                      _emailController.clear();
                      _passwordController.clear();                      
                      });
                    }
                    //emailCon = "";/
              Navigator.of(context).push(
              PageRouteBuilder( opaque: false,pageBuilder: (BuildContext context,___, __){
                        return BaseAlertDialog(
                          yes: "OK",
                          content: "$return_msg_to_show",
                          noOnPressed: (){Navigator.pop(context);},
                          title: "@ $repsRes ",
                          yesOnPressed: (){Navigator.pop(context);},
                        );
                      }                      
                ));
                  });
              }else{
                // alert not field shoud be empty
                print("No field should be empty");
                  Navigator.of(context).push(
 PageRouteBuilder( opaque: false,pageBuilder: (BuildContext context,___, __){
              return BaseAlertDialog(
                yes: "OK",
                content: " ${passCon.isEmpty || emailCon.isEmpty || nameCon.isEmpty? "Please fill all fields.":""}\n${passCon.length < 6? "Password should be six(6) or more ":""}\n${isValidEmail == false?"Make sure the email or name are properly formatted":""}",
                //noOnPressed: (){Navigator.pop(context);},
                title: "@from Codeish",
                yesOnPressed: (){Navigator.pop(context);},
              );
            }                      
          ));
    }              
            }),

SizedBox(height: 20,),
            GestureDetector(onTap: (){


            },
            child: Text("Forgot password?",
            style: TextStyle(color: Colors.white,))), 
                 
                 ],
               ),
    );
  }
}