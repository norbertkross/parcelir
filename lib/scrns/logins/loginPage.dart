import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parcelir/reuse/giveStatic.dart';
import 'package:parcelir/reuse/mediaData.dart';
import 'package:parcelir/scrns/logins/loginBody.dart';
import 'package:parcelir/scrns/logins/registerBody.dart';
import 'package:parcelir/serveGlobal/serveglobal.dart';



class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
bool isLogin;






  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
         children: <Widget>[
           Container(
             decoration: BoxDecoration(
             image: DecorationImage(image: AssetImage("${ServeGlobal.vvIP}"),fit: BoxFit.cover),             
             ),
           ),
          //  BackdropFilter(
          //    filter: ImageFilter.blur(sigmaX: 4,sigmaY:4),
          //    child: 
             Container(
               width:MediaQueryDataR(context).mdw(1),
               height: MediaQueryDataR(context).mdh(1),
               decoration: BoxDecoration(
                 color: Colors.grey.shade200.withOpacity(.3)
               ),
             ),
          // ),

           Center(
             child: ClipRRect(
               borderRadius:BorderRadius.only(topRight: Radius.circular(80),
               topLeft: Radius.circular(8),
               bottomLeft: Radius.circular(8),
               bottomRight: Radius.circular(8),
               ), 
              //  BorderRadius.horizontal(
              //    right: Radius.circular(60)
              //  ),
               child: Container(
                   width:MediaQueryDataR(context).mdw(.85),
                   height:MediaQueryDataR(context).ornt() == true?MediaQueryDataR(context).mdh(.70):MediaQueryDataR(context).mdh(.90),
                   color: Colors.red.withOpacity(.5),
                   child: Stack(
                     children: <Widget>[
                       ListView(
                         shrinkWrap: true,
                         children: <Widget>[
                           isLogin ==null?Container():isLogin ==true?
                           LoginBody():RegisterBody(),
                           Column(
                             children: <Widget>[
                  isLogin == null?  SizedBox(
                     height:MediaQuery.of(context).orientation == Orientation.landscape?100:200,
                     width: 150,
                     child: 
                     CircleAvatar(
                       backgroundColor: Colors.red.withOpacity(.0),
                    child: 
                     ClipRRect(
                       borderRadius: BorderRadius.circular(60),
                       child: Image.asset("${ServeGlobal.imgUrl}"),
                       ),
                       ),
                     ):Container(),
        isLogin == null?SizedBox(
          //height: MediaQueryDataR(context).mdh(.2),
        ):Container(),    

        SizedBox(height: 50,),
        isLogin == null?CupertinoButton(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            child: Text(" Login    "
            ,style: TextStyle(color: Colors.red),
            ), onPressed: (){
              setState(() {
                isLogin= true;
              });
            }):Container(),

    SizedBox(height: 20,),

         isLogin == null? CupertinoButton(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            child: Text("Register"
            ,style: TextStyle(color: Colors.red),
            ), onPressed: (){
              setState(() {
                isLogin= false;
              });              
            }):Container(),            
    SizedBox(height: 100,),

                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginBody(isAdmin: true)));
                        
                        // setState(() {
                        //   isLogin= true;
                        // });
                      },
                      child: Text("Administrator",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)))
                  ],
                ),
                             ],
                           )
                         ],
                       ),

isLogin != null? IconButton(icon: Icon(Icons.close,color: Colors.white,size: 35,), 
onPressed: (){
                setState(() {
                isLogin = null;
              });
}):Container()

                     ],
                   ),             
               ),
             ),
           )
         ],
       ),
    );
  }
}