import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parcelir/reuse/mediaData.dart';
import 'package:parcelir/serveGlobal/serveglobal.dart';

class ViewItemsDetails extends StatefulWidget {
  @override
  _ViewItemsDetailsState createState() => _ViewItemsDetailsState();
}

class _ViewItemsDetailsState extends State<ViewItemsDetails> {

  bool itemIsdeliver = false;

  Widget inputItem(BuildContext context,
  {String label,String value,
  Color topTolor,}){
    return Padding(
            padding: 
            EdgeInsets.symmetric(
              vertical: 5),
             child:Column(
              children: <Widget>[
               ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                 child: Container(
                  width: MediaQuery.of(context).size.width*.9,
                  color: topTolor ==null?Colors.red.withOpacity(.6):topTolor.withOpacity(.6),
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("  ${label==null?"Data Filed":label}",
                      style: TextStyle(color: Colors.white),),
                  ), 
                ),
              ),                      
                      ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                child: Container(
                      width: MediaQuery.of(context).size.width*.9,
                      color: Colors.green.withOpacity(.6),
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("  ${value==null?"Data Filed":value}",
                      style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
                    ],
                  ),
                );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(" Delivery Details"),
        actions: <Widget>[
          Icon(Icons.business_center),
          SizedBox(width: 10,)],
      ),  
      body: ListView(
        children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  color: Colors.white,
                  elevation: 30,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(  
                        crossAxisAlignment: CrossAxisAlignment.start,                    
                        children: <Widget>[  

                          RichText(
                            text: TextSpan(
                            children: [
                              TextSpan(text:"Order No",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                              TextSpan(text:" : #7474",style: TextStyle(color: Colors.black.withOpacity(.4),fontWeight: FontWeight.bold)),
                            ]
                          ),),  
                          
Table(
    children: [  
    TableRow(children: [  
      Text("\nItem Delivered",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),  
          Checkbox(
            value: itemIsdeliver,checkColor: Colors.white,
          activeColor: Colors.red, onChanged: (retVal){
        setState(() {  
          itemIsdeliver = retVal;  
        });  
      }),  
    ]),
  ]),
                          
                          SizedBox(height: 15,),
                           Text("Delivery Details",
                            style: TextStyle(color: Colors.red,fontSize: 15,
                            fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(ServeGlobal.imgUrl)//
                                )),
                            ),
                          ),
          SizedBox(height: 20,),
           inputItem(context,label: "Item(s)",value: "HP Pavillion x360 laptop and charger baterry and accessories"),
          inputItem(context,label: "Sender",value: "Aberor Norbert Eugene"),
          inputItem(context,label: "Sender Phone",value: "0557340556"),
          inputItem(context,label: "Reciepient",value: "Aberor Emmanuel Davis"),
          inputItem(context,label: "Reciepient Phone",value: "0241898937"),
          inputItem(context,label: "From",value: "Kumasi"),
          inputItem(context,label: "Destination",value: "Accra"),
          inputItem(context,label: "Date & Time",value: "Mon 12 Jan, 2020  || 12:64 AM"),
         
          // inputItem(context,label: "Sender",value: "Aberor Norbert Eugene"),
          // inputItem(context,label: "Sender",value: "Aberor Norbert Eugene"),
          // inputItem(context),
          // inputItem(context),
          // inputItem(context),

            Divider(height: 70,thickness: 3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                  children: [
                    TextSpan(text:"Total Cost",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                    TextSpan(text:" :  \$7474",style: TextStyle(color: Colors.black.withOpacity(.4),fontWeight: FontWeight.bold)),
                  ]
                ),),
              ],
              ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ],
      ),    
    );
  }
}