import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:parcelir/introscreen.dart';
import 'package:parcelir/scrns/aboutus.dart';
import 'package:parcelir/scrns/recievingScreen.dart';
import 'package:parcelir/scrns/sendingScreen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyItems extends StatefulWidget {
  @override
  _MyItemsState createState() => _MyItemsState();
}

class _MyItemsState extends State<MyItems> with SingleTickerProviderStateMixin{
  
bool isCollapsed = true;
AnimationController animationController;
int curnIndex = 0;
Duration animDuration = Duration(milliseconds: 500);
String isAdmin = "";
String usercontact = "";
String email = "";
String name = "";
String userid = "";

getIsAdmin()async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
    isAdmin = (_prefs.getString('iamadmin') ?? "");
    usercontact = (_prefs.getString('myphonenumber') ?? "");
    email = (_prefs.getString('email') ?? "");
    name = (_prefs.getString('name') ?? "");
    userid = (_prefs.getString('userid') ?? "");

  print("IAMADMIN VALUE: $isAdmin");
  print(", $usercontact");
  print(", $name");
  print(", $userid");
}





Future<List>getdata()async{
//print("UserId in Get Method : $userId");
//print("Loading ....");
String theUrl ="http://10.0.2.2:5000/transactions?contact=$usercontact";
String theUrlAdmin ="http://10.0.2.2:5000/transactions";
var res = await http.post(Uri.encodeFull(isAdmin.isNotEmpty?theUrlAdmin:theUrl),
headers: {
"Accept":"application/json",
'Content-Type': 'application/x-www-form-urlencoded',
},

).catchError((onError){
  //print("THE PROBLEM: \n${onError.toString()}\n");
});

var responseBody = json.decode(res.body);

print("results ::\n\n$responseBody\n\n");
//print("item ${responseBody[0]["head"]} ${responseBody[0]["message"]}");
 return responseBody;
}




  Widget inFront(){
double mwidth = MediaQuery.of(context).size.width; 
double mheight = MediaQuery.of(context).size.height;    
  return AnimatedPositioned(
    duration: animDuration,
    top:isCollapsed ?0 : mheight*.05,
    bottom:isCollapsed ?0 : mheight*.05,
    right:isCollapsed ?0 : mwidth*-.3,
    left:isCollapsed ?0 : mwidth*.7,
      child: 
      // ClipRRect(
      //   borderRadius:isCollapsed == false?BorderRadius.circular(holdValuesToChange):BorderRadius.circular(0.0),
      //   child:
         Card(
          margin: EdgeInsets.all(0.0),
            elevation: 30.0,     
          child:ListView(
        children: <Widget>[

              ListTile(leading: IconButton(
                onPressed: (){
                  setState(() {
                    isCollapsed =!isCollapsed;
                  });
                },
                icon: Icon(isCollapsed == true? Icons.menu:Icons.close,color: Colors.red,),),
                title: Text("Parcelir ... delivery Ninja",style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),),

                ),
FutureBuilder(
      future:getdata() ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        ConnectionState  conn = snapshot.connectionState;

        if(conn == ConnectionState.none){
          return Container(color: Colors.blueGrey.withOpacity(.7),);
        }
        if(conn == ConnectionState.waiting){
            return Center(
                child:Center(child:Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.35),
                  child: CircularProgressIndicator(),
                ),)
              ) ;
        }
        if(snapshot.hasError){
             // return Center(child:Text('Check Your Connection ${snapshot.error}') ,) ;
             return Center(child:Text('Could Not Connect ',style: TextStyle(color: Colors.green),) ,) ;
        }else{

          List snapData = snapshot.data;
  
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapData.length,
            itemBuilder: (context,index){


               String senderName = snapData[index]["senderName"];
               String reciepientName = snapData[index]["reciepientName"];
               String picture = snapData[index]["picture"];
               String recieverPicture = snapData[index]["recieverPicture"];
               String isDelivered = snapData[index]["isDelivered"];
               String payOnDelivery = snapData[index]["payOnDelivery"];
               String delivid = snapData[index]["delivid"].toString();

              return  snapData.length == 0?Center(
                child: Text("No Transactions Yet",style: TextStyle(color: Colors.red),),
              ) : Column(
            children: <Widget>[

              GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> 
                    isAdmin.isEmpty?RecievingScreen(
                      //isAdmin:  false,
                      delivered:isDelivered == "yes"?true:false ,
                      imgUrl: recieverPicture,
                      paymentMtd: payOnDelivery,
                    ):RecievingScreen(
                      isAdmin: true,
                      delivered: isDelivered == "yes"?true:false ,
                      imgUrl: recieverPicture,
                      paymentMtd: payOnDelivery,
                      theId: delivid,

                    )));
                  },
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  child: Container(
                    width: MediaQuery.of(context).size.width*.9,
                    height: MediaQuery.of(context).size.height*.3,
                    //child: ,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(picture),
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                ),
              ),  

              Padding(
                padding: const EdgeInsets.only(bottom:15.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                  child: Container(
                    width: MediaQuery.of(context).size.width*.9,
                    //height: MediaQuery.of(context).size.height*.3,                  
                    color: Colors.red,
                    child: ListTile(
                      leading: CircleAvatar(
                        //child: N,
                        backgroundImage: NetworkImage(recieverPicture),
                      ),
                      title: Text("$reciepientName",style: TextStyle(color: Colors.white),),
                      subtitle: Text("$senderName",style: TextStyle(color: Colors.white),),
                      trailing: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 50,
                          height: 30,
                          color: Colors.black.withOpacity(.5),
                          child: Icon(isDelivered == "yes"? Icons.done_all :Icons.warning,color: Colors.green,),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );

            });
        }})


         
        ],
      ),
        ),
     // ),
  );
  }



  Widget baseOf(){
  return GestureDetector(
    onTap: (){
    print("underneat container");
    setState(() {
    isCollapsed = ! isCollapsed; 
  });    
    },
    child: Container(
      color:Colors.red.withOpacity(.4) ,
           width: MediaQuery.of(context).size.width,  
            child: ListView(
              children: <Widget>[      
                Column(
                    children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10.0,),
                            CircleAvatar(
                              radius: 50.0,
                              child: Text(isAdmin.isNotEmpty?"A": name.isEmpty?"": name.substring(0,1).toUpperCase()),
                              //backgroundImage: AssetImage("assets/frontendninja.jpg"),
                            ),
                          ],
                        ),

                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10.0),
                          child: 
                          Column(
                            children: <Widget>[
                              SizedBox(
                                  height: 10.0,
                                ),
                                ListTile(
                                  title: Text(isAdmin.isNotEmpty?"Administrator":"$name ",
                                    style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: 
                                    FontWeight.bold),),
                                    subtitle: Text(isAdmin.isNotEmpty?"0000 000 000":"$usercontact",
                                    style: TextStyle(fontSize: 14,color: Colors.white,),),
                                ),

                              SizedBox(
                                  height: 20.0,
                                ),                            

                             isAdmin.isNotEmpty? ListTile(
                                  onTap: (){
                                    setState(() {
                                     curnIndex = 0; 
                                    });
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SendingDetails()));
                                  },
                                 // contentPadding: EdgeInsets.symmetric(horizontal:0.0),
                                  title: Text("Create Send ",
                                    style: TextStyle(fontSize: curnIndex == 0?20:16,
                                     color: curnIndex == 0?Colors.white:Colors.white,
                                    fontWeight:curnIndex == 0?FontWeight.bold:FontWeight.w300),),
                                ):Container(),   
                                
                            // isAdmin.isNotEmpty? ListTile(
                            //       onTap: (){
                            //         setState(() {
                            //          curnIndex = 1; 
                            //          print("current index $curnIndex");
                            //         });

                            //         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RecievingScreen()));

                            //       },                                
                            //       title: Text("Recieve",
                            //         style: TextStyle(fontSize:curnIndex == 1?20:16,
                            //         color:curnIndex == 1?Colors.white:Colors.white,
                            //         fontWeight:curnIndex == 1?FontWeight.bold:FontWeight.w300),),
                            //     ) : Container(),    

                                ListTile(
                                  onTap: (){
                                    setState(() {
                                     curnIndex = 2; 
                                    });
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>About(isAbout: true,)));

                                  },                                
                                  title: Text("About Us ",
                                    style: TextStyle(fontSize:curnIndex == 2?20: 16,
                                    color: curnIndex == 2?Colors.white:Colors.white,
                                    fontWeight:curnIndex == 2?FontWeight.bold:FontWeight.w300),),
                                ), 

                                ListTile(
                                  onTap: (){
                                    setState(() {
                                     curnIndex = 3; 
                                    });

                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>About(isAbout: false,)));
                                  },                                
                                  title: Text("Our Contact ",
                                    style: TextStyle(fontSize:curnIndex == 3?20: 16,
                                    color: curnIndex == 3?Colors.white:Colors.white,
                                    fontWeight:curnIndex == 3?FontWeight.bold:FontWeight.w300),),
                                ),    

  
                                ListTile(
                                  onTap: ()async{
                           SharedPreferences _prefs = await SharedPreferences.getInstance();
                            _prefs.setString('iamadmin',"") ;
                            _prefs.setString('myphonenumber',"");
                            _prefs.setString('email',"");
                            _prefs.setString('name',"");
                            _prefs.setString('userid',"");                                    
                                    setState(() {
                                     curnIndex = 0; 
                                     print("logged out !!!");
                                    });
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>IntroScreen()));
                                  },
                                  leading: Icon(Icons.exit_to_app,color: Colors.white,),
                                  title: Text("Log Out ",
                                    style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                                ),                                                                                                                                                                      
                            ],
                          ),
                        )
                  ],
                )
              ],
            ), 
          ),
        );
  }

  @override
  void initState() {
    // TODO: implement initState
    getIsAdmin();
    super.initState();
    animationController = 
    AnimationController(vsync: this,duration: Duration(milliseconds: 300));
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
              children: <Widget>[
                  baseOf(),
                  inFront(),                                
                    ],
                   ),
    );
  }
}