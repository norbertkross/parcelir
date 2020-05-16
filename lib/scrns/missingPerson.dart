import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parcelir/reuse/mediaData.dart';
import 'package:intl/intl.dart';
import 'package:parcelir/serveGlobal/serveglobal.dart';

class MissingPerson extends StatefulWidget {
  @override
  _MissingPersonState createState() => _MissingPersonState();
}

class _MissingPersonState extends State<MissingPerson> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime =TimeOfDay.now();

  String fdate(){
      String formatedDate = DateFormat("EEE MMM d, yyyy").format(selectedDate);
    return formatedDate;
  }

  String ftime(){
//    "h:mm a"
    String formatedTime =" ${selectedTime.format(context)}";
     return formatedTime;
  }
    Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }


Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime, builder: (BuildContext context, Widget child) {
           return MediaQuery(
             data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );});

    if (picked_s != null && picked_s != selectedTime )
      setState(() {
        selectedTime = picked_s;
      });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("\n$selectedDate");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
             decoration: BoxDecoration(
             image: DecorationImage(
               image: AssetImage("${ServeGlobal.vvIP}"),fit: BoxFit.cover),             
             ),
          ),
                Container(
                   color: Colors.grey.shade200.withOpacity(.7),
                   width: MediaQueryDataR(context).ornt()== true?  MediaQueryDataR(context).mdw(1):MediaQueryDataR(context).mdh(1),
                   height: MediaQueryDataR(context).ornt()== true? MediaQueryDataR(context).mdh(1):MediaQueryDataR(context).mdw(1),                
                          ),
          ListView(
            shrinkWrap: true,
           // padding: EdgeInsets.all(0.0),
            children: <Widget>[

              Container(
                  //  color: Colors.grey.shade200.withOpacity(.7),
                  //  width: MediaQueryDataR(context).ornt()== true?  MediaQueryDataR(context).mdw(1):MediaQueryDataR(context).mdh(1),
                  //  height: MediaQueryDataR(context).ornt()== true? MediaQueryDataR(context).mdh(1):MediaQueryDataR(context).mdw(1),
                   child: Column(
                     children: <Widget>[
                       ListTile(
                         leading: IconButton(icon: Icon(CupertinoIcons.back,size: 35,color: Colors.orange,), onPressed: (){}),
                       ),
                       SizedBox(
                         height: 50,
                       ), 

                       MediaQueryDataR(context).rbutn(
                         action: (){},
                         txt: "Details of Missing Person"                         
                       ),
                       
        SizedBox(
          height: 5,
        ),

        Stack(
          children: <Widget>[
            CircleAvatar(
              radius: 100,
              child: CircleAvatar(backgroundColor: Colors.black.withOpacity(.5),child: IconButton(icon: Icon(Icons.add_a_photo), onPressed: (){})),
              backgroundImage: AssetImage("${ServeGlobal.vvIP}"),
            ),
          ],
        ),

      SizedBox(
          height: 5,
        ),
    Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextField(    
    decoration: InputDecoration(labelText: 'Full name',
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
    decoration: InputDecoration(labelText: 'email',
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
    Table(children: [
  TableRow(children: [
    Padding(
      padding: EdgeInsets.all(8.0),
      child: RaisedButton(onPressed: null,child: 
      Text(fdate(),style: TextStyle(color: Colors.red),),),
    ),
       Padding(
         padding: EdgeInsets.all(8.0),
         child: RaisedButton(onPressed: null,child: Text(
           //selectedTime.toString(),
           ftime(),
           style: TextStyle(color: Colors.red),),),
       ),
  ]),

]),
  Table(children: [
  TableRow(children: [
    Padding(
      padding: EdgeInsets.all(8.0),
      child: RaisedButton(onPressed: (){_selectDate(context);},child: Text("Date",style: TextStyle(color: Colors.red),),),
    ),
       Padding(
         padding: EdgeInsets.all(8.0),
         child: RaisedButton(onPressed: (){_selectTime(context);},child: Text("Time",style: TextStyle(color: Colors.red),),),
       ),
  ]),

]),

    MediaQueryDataR(context).rbutn(
        action: (){},
        txt: "Send "                        
        ),
                     ],
                   ),
              ),

              
            ],
          ),          
        ],
      ),
    );
  }
}  