import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:parcelir/reuse/giveStatic.dart';
import 'package:parcelir/reuse/mediaData.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:toast/toast.dart';



class SendingDetails extends StatefulWidget {
  @override
  _SendingDetailsState createState() => _SendingDetailsState();
}

class _SendingDetailsState extends State<SendingDetails> {

TextEditingController _nameController = TextEditingController();
TextEditingController _reciepientNameController = TextEditingController();
TextEditingController _smobileController = TextEditingController();
TextEditingController _rmobileController = TextEditingController();
TextEditingController _destinationController = TextEditingController();
TextEditingController _itemNameController = TextEditingController();
TextEditingController _itemsCostController = TextEditingController();
TextEditingController _itemspicController = TextEditingController();
TextEditingController _rNameController = TextEditingController();
TextEditingController _rNumberController = TextEditingController();
TextEditingController _payOnDeliveryController = TextEditingController();

String get senderName => _nameController.text;
String get reciepientName => _reciepientNameController.text;
String get smobile => _smobileController.text;
String get rmobile => _rmobileController.text;
String get destination => _destinationController.text;
String get itemName => _itemNameController.text;
String get itemsCost => _itemsCostController.text;
String get itemspic => _itemspicController.text;
// String get rName => _rNameController.text;
// String get rNumber => _rNumberController.text;
String get payOnDelivery => _payOnDeliveryController.text;

  

Widget loadMe(BuildContext context){
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: Colors.black.withOpacity(.8),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime =TimeOfDay.now();

  String baseUrl = GiveStatic.baseOfUrl;

  File imageFile;
  //bool imageFile;
  bool payOndeliver = false;

  bool isLoading = false;

//   String fdate(){
//       String formatedDate = DateFormat("EEE MMM d, yyyy").format(selectedDate);
//     return formatedDate;
//   }

//   String ftime(){
// //    "h:mm a"
//     String formatedTime =" ${selectedTime.format(context)}";
//      return formatedTime;
//   }
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



sendDeliveryDetails()async{

String theUrl ="$baseUrl/sendDelivery?senderName=$senderName&reciepientName=$reciepientName&smobile=$smobile&rmobile=$rmobile&destination=$destination&itemName=$itemName&itemsCost=$itemsCost&payOnDelivery=${payOnDelivery.isNotEmpty?payOnDelivery:"0.0"}&itemspic=https://rwerwer.hdfdhf/dhgfd";
var res = await http.post(Uri.encodeFull(theUrl),

headers: {
"Accept":"application/json",
'Content-Type': 'application/x-www-form-urlencoded',
},

).catchError((onError){
  //print("THE PROBLEM: \n${onError.toString()}\n");
});

var responseBody = json.decode(res.body);

//print("results ::\n\n$responseBody\n\n");
//print("item ${responseBody[0]["head"]} ${responseBody[0]["message"]}");
 return responseBody;
}





  Widget inputItem(BuildContext context,
  {String hintword,String label,TextEditingController controllerOf,
  Color topTolor,TextInputType keyboard,var hide}){
    return Padding(
            padding: 
            EdgeInsets.symmetric(horizontal: MediaQueryDataR(context).mdw(.05),vertical: 5),
             child:Column(
              children: <Widget>[
               ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                 child: Container(
                  width: MediaQuery.of(context).size.width*.9,
                  //height: MediaQuery.of(context).size.height*.3,                  
                  color: topTolor ==null?Colors.red:topTolor,
                  child: ListTile(
                    title: Text("  ${label==null?"Data Filed":label}",
                    style: TextStyle(color: Colors.white),),

                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 50,
                        height: 30,
                        color: Colors.black.withOpacity(.5),
                        child: Icon(Icons.done,color: Colors.green,),
                      ),
                    ),
                  ),
                ),
              ),                      
                    hide == null? ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                child: Container(
                      width: MediaQuery.of(context).size.width*.9,
                      //height: MediaQuery.of(context).size.height*.3,                  
                      color: Colors.green,
                      child: ListTile(

                        title: TextField(
                             controller: controllerOf,
                              maxLines: null,
                              keyboardType:keyboard==null?TextInputType.multiline:keyboard,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "  ${hintword==null?"Enter data":hintword}",
                                hintStyle: TextStyle(color: Colors.white)
                              ),
                            ),
                      ),
                ),
              ):Container(),
                    ],
                  ),
                );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sending Details"),
        actions: <Widget>[
          Icon(Icons.directions_bus,color: Colors.white,),
          SizedBox(width: 10,)
        ],
      ),
      body: Center(
        child: Stack( 
          children: [
            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    inputItem(context, label:"Sender Name", controllerOf:_nameController,keyboard: TextInputType.text),
                     inputItem(context, label:"Mobile Number", controllerOf:_smobileController,keyboard: TextInputType.number),
                     inputItem(context, label:"Destination", controllerOf:_destinationController,keyboard: TextInputType.text),
                     SizedBox(height: 10,),


                    SizedBox(height: 10,),


                       inputItem(context, label:"Item(s) name and Quantity", controllerOf:_itemNameController,),
                        inputItem(context, label:"Estimated Value of Items", controllerOf:_itemsCostController,keyboard: TextInputType.number),

                         inputItem(context, label:"Item(s) Picture", hide: true),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQueryDataR(context).mdw(.05),vertical: 0),
                  child: ClipRRect(
                    borderRadius:BorderRadius.vertical(bottom: Radius.circular(20)),// BorderRadius.circular(20),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height:MediaQueryDataR(context).mdh(.3),
                          color:imageFile ==null? Colors.green.withOpacity(.4):null,
                          decoration: imageFile ==null?null:
                          BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(imageFile)
                            )
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(height: MediaQueryDataR(context).mdh(.1),),
                            Center(
                              child: Wrap(
                                alignment: WrapAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      print("picture tapped");
                                      getImageGallery();
                                      // setState(() {
                                      //   imageFile = true;
                                      // });
                                    },
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.red.withOpacity(.3),
                                      child: 
                                      //IconButton(
                                        //icon: 
                                        Icon(Icons.image,color: Colors.white,
                                        ),
                                      //   onPressed: (){},
                                      // ),
                                    ),
                                  ),

                                  // CAmera SOurce Image
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: (){
                                      print("picture tapped");
                                      getImageCamera();
                                      // setState(() {
                                      //   imageFile = true;
                                      // });
                                    },
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.red.withOpacity(.3),
                                      child: 
                                      //IconButton(
                                        //icon: 
                                        Icon(Icons.add_a_photo,color: Colors.white,
                                        ),
                                      //   onPressed: (){},
                                      // ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    ),
                                      ),                
                         
                         SizedBox(height: 20,),
                         Text("// Recepient Info",style: TextStyle(fontWeight: FontWeight.bold),),
                         SizedBox(height: 5,),
                         inputItem(context, label:"Recepient name", 
                         controllerOf:_reciepientNameController,keyboard: TextInputType.text),
                         inputItem(context, label:"Recepient Number",
                         controllerOf:_rmobileController,keyboard: TextInputType.number),
                          
                         SizedBox(height: 10,), 
Table(children: [
  TableRow(children: [
    Checkbox(value: payOndeliver,checkColor: Colors.red,activeColor: Colors.white, onChanged: (retVal){
      setState(() {
            payOndeliver = retVal;
      });
    }),
    Text("\nPay On Delivery",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
  ]),

]),
                        
payOndeliver == false?inputItem(context, label:"Enter Amount", 
controllerOf:_payOnDeliveryController,keyboard: TextInputType.number):Container(),

    MediaQueryDataR(context).rbutn(
            action: (){

              
               if(
             senderName.isNotEmpty && reciepientName.isNotEmpty  && smobile.isNotEmpty 
            && rmobile.isNotEmpty && destination.isNotEmpty && itemName.isNotEmpty && itemsCost.isNotEmpty 
            && imageFile != null        
              ){

                  setState(() {
                    isLoading = true;
                  });
                  print("Inside Sendrr");
            upload(File(imageFile.path));

               }
              else{
               print("Invalid Data Sendrrrrrr");   
                Toast.show("A problem Occured ", context, 
              duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER,
              backgroundColor: Colors.red.withOpacity(.6),
              textColor: Colors.white
              );

              }
            },
            txt: "Send "                        
            ),

            SizedBox(height: 30),
                  ],
                )
              ],
            ),

          isLoading == true?loadMe(context) :Container()
          ],
        ),
      ),
    );
  }



  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = image;
    });
  }
  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageFile = image;
    });
  }


upload(File imageFile) async {    
      // open a bytestream
      //var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var stream = new http.ByteStream(Stream.castFrom(imageFile.openRead()));
      // get file length
      var length = await imageFile.length();
//47162
      // string to uri
      //var uri = Uri.parse("http://ip:8082/composer/predict");
      String theUrl ="http://10.0.2.2:5000/sendDelivery?senderName=$senderName&reciepientName=$reciepientName&smobile=$smobile&rmobile=$rmobile&destination=$destination&itemName=$itemName&itemsCost=$itemsCost&payOnDelivery=${payOnDelivery.isNotEmpty?payOnDelivery:"0.0"}";

      var uri = Uri.parse(theUrl);

      // create multipart request
      var request = new http.MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFile = new http.MultipartFile('picture', stream, length,
          filename: basename(imageFile.path));

      // add file to multipart
      request.files.add(multipartFile);

      // send
      var response = await request.send();
      print(response.statusCode);

      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
          setState(() {
              isLoading = false;
            }); 


      });
      // .onDone(() {
      //           setState(() {
      //               isLoading = false;
      //             });
      // });
    }




}