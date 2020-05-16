import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyItems extends StatefulWidget {
  @override
  _MyItemsState createState() => _MyItemsState();
}

class _MyItemsState extends State<MyItems> with SingleTickerProviderStateMixin{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isCollapsed = true;
  AnimationController animationController;
  int curnIndex = 0;
 Duration animDuration = Duration(milliseconds: 500);
Future<String> isAdmin;

getIsAdmin()async{
    isAdmin = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('iamadmin') ?? "");
    }); 
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
          Column(
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
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                child: Container(
                  width: MediaQuery.of(context).size.width*.9,
                  height: MediaQuery.of(context).size.height*.3,
                  //child: ,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/frontendninja.jpg"),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                child: Container(
                  width: MediaQuery.of(context).size.width*.9,
                  //height: MediaQuery.of(context).size.height*.3,                  
                  color: Colors.red,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text("A"),
                    ),
                    title: Text("Aberor Norbert Eugene",style: TextStyle(color: Colors.white),),
                    subtitle: Text("Emmanuel Davis Aberor",style: TextStyle(color: Colors.white),),
                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 50,
                        height: 30,
                        color: Colors.black.withOpacity(.5),
                        child: Icon(Icons.done_all,color: Colors.green,),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
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
      color:Colors.blue ,
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
                              backgroundImage: AssetImage("assets/frontendninja.jpg"),
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
                                  title: Text("Aberor Norbert Eugene ",
                                    style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: 
                                    FontWeight.bold),),
                                    subtitle: Text("San Francisco, CA",
                                    style: TextStyle(fontSize: 14,color: Colors.white,),),
                                ),

                              SizedBox(
                                  height: 20.0,
                                ),                            

                            isAdmin != null || isAdmin.toString().isNotEmpty? ListTile(
                                  onTap: (){
                                    setState(() {
                                     curnIndex = 0; 
                                    });
                                  },
                                 // contentPadding: EdgeInsets.symmetric(horizontal:0.0),
                                  title: Text("Create Send ",
                                    style: TextStyle(fontSize: curnIndex == 0?20:16,
                                     color: curnIndex == 0?Colors.white:Colors.white,
                                    fontWeight:curnIndex == 0?FontWeight.bold:FontWeight.w300),),
                                ):Container(),   
                                
                            isAdmin != null || isAdmin.toString().isNotEmpty? ListTile(
                                  onTap: (){
                                    setState(() {
                                     curnIndex = 1; 
                                     print("current index $curnIndex");
                                    });
                                  },                                
                                  title: Text("Recieve",
                                    style: TextStyle(fontSize:curnIndex == 1?20:16,
                                    color:curnIndex == 1?Colors.white:Colors.white,
                                    fontWeight:curnIndex == 1?FontWeight.bold:FontWeight.w300),),
                                ) : Container(),    

                                ListTile(
                                  onTap: (){
                                    setState(() {
                                     curnIndex = 2; 
                                    });
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
                                  },                                
                                  title: Text("Our Contact ",
                                    style: TextStyle(fontSize:curnIndex == 3?20: 16,
                                    color: curnIndex == 3?Colors.white:Colors.white,
                                    fontWeight:curnIndex == 3?FontWeight.bold:FontWeight.w300),),
                                ),    

  
                                ListTile(
                                  onTap: (){
                                    setState(() {
                                     curnIndex = 0; 
                                     print("logged out !!!");
                                    });
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