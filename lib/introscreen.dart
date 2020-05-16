import 'package:flutter/material.dart';
import 'package:parcelir/scrns/logins/loginPage.dart';
import 'package:parcelir/serveGlobal/serveglobal.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();


    Future.delayed(Duration(seconds: 3),(){
      print("About to Push To Login");
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
       body: Stack(
         children: <Widget>[
           ListView(
             children: <Widget>[
               Column(
                 children: <Widget>[
                  //  SizedBox(
                  //    height: 20,
                  //  ),
                   SizedBox(
                     height:MediaQuery.of(context).orientation == Orientation.landscape?100:200,
                     width: 200,
                     child: 
                     CircleAvatar(
                       backgroundColor: Colors.red,
                    child: 
                     ClipRRect(
                       borderRadius: BorderRadius.circular(200),
                       child: Image.asset("${ServeGlobal.imgUrl}"),
                       ),
                       ),
                     ),

                     SizedBox(
                       height: 100,
                     ),
                     
                 ],
               )
             ],
           ),

                     Center(
                       child: Text(
                         "delivery with you in mind...",style: TextStyle(
                         color: Colors.white,fontWeight: FontWeight.bold,
                         fontSize: 18
                       ),),
                     ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("from norbertKross\n",style: TextStyle(
                       color: Colors.purple,fontWeight: FontWeight.bold,
                       fontSize: 18
                     ),),
                )           
         ],
       ),
    );
  }
}