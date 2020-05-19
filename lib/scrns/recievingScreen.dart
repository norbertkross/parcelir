import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:parcelir/reuse/mediaData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:parcelir/serveGlobal/serveglobal.dart';
import 'package:toast/toast.dart';

class RecievingScreen extends StatefulWidget {
  final bool isAdmin;
  final String imgUrl;
  final String paymentMtd;
  final bool delivered;
  final String theId;
  RecievingScreen({this.isAdmin,this.imgUrl,this.delivered,this.paymentMtd,this.theId});
  @override
  _RecievingScreenState createState() => _RecievingScreenState();
}

class _RecievingScreenState extends State<RecievingScreen> {
 

TextEditingController _paymentController = TextEditingController();
String get payment => _paymentController.text;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime =TimeOfDay.now();

  File imageFile;

  bool itemIsdeliver = true;
  bool isLoading = false;



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

  Widget inputItem(BuildContext context,
  {String hintword,String label,TextEditingController controllerOf,
  Color topTolor,TextInputType keyboard}){
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
                      ClipRRect(
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
                                //labelText: ,
                                enabled: widget.isAdmin == true? true: false ,
                                border: InputBorder.none,
                                hintText: "  ${hintword==null?"Enter data":hintword}",
                                hintStyle: TextStyle(color: Colors.white)
                              ),
                            ),
                      ),
                ),
              ),
                    ],
                  ),
                );
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();

    itemIsdeliver = widget.delivered;
    print("\n The IMAGURL: ${widget.imgUrl}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Recieving Items"),
        actions: <Widget>[
          Icon(Icons.business_center),
          SizedBox(width: 10,)],
      ),
      body: Center(
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[

            SizedBox(height: 20,),
              Padding(
                padding: 
                EdgeInsets.symmetric(horizontal: MediaQueryDataR(context).mdw(.05),),
                 child:Column(
                  children: <Widget>[
                   ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                     child: Container(
                      width: MediaQuery.of(context).size.width*.9,
                      //height: MediaQuery.of(context).size.height*.3,                  
                      color:Colors.red,
                      child: ListTile(
                        title: Text("  Reciepient Id",
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

                        ],
                      ),
                    ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQueryDataR(context).mdw(.05),),
                  child:  ClipRRect(
                    borderRadius:BorderRadius.vertical(bottom: Radius.circular(20)),// BorderRadius.circular(20),
                    child: Stack(
                      children: <Widget>[

                        widget.isAdmin ==true && imageFile == null?
                        Container(
                          height:MediaQueryDataR(context).mdh(.3),
                          color: imageFile ==null? Colors.green.withOpacity(.4):null,
                        )
                        :
                        Container(
                          height:MediaQueryDataR(context).mdh(.3),
                          //color: imageFile ==null? Colors.green.withOpacity(.4):null,
                          decoration: 
                          BoxDecoration(
                            image:  DecorationImage(
                              fit: BoxFit.cover,
                              image: widget.isAdmin == true? FileImage(imageFile): NetworkImage(widget.imgUrl??""), 
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
                                widget.isAdmin == true? GestureDetector(
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
                                  ) : Container(),

                                  // CAmera SOurce Image
                                  SizedBox(width: 10,),
                                widget.isAdmin == true?  GestureDetector(
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
                                  ) : Container(),

                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    ),
                                      ), 

                                      SizedBox(
                                        height: 10,
                                      ),                
                        //  inputItem(context, label:"Recepient name", 
                        //  controllerOf:_reciepientNameController,keyboard: TextInputType.text),
                        //  inputItem(context, label:"Recepient Number",
                        //  controllerOf:_rmobileController,keyboard: TextInputType.number),
                    
                    SizedBox(height: 10,),
                    widget.paymentMtd != "0.0"? Container(): inputItem(context, label:"Payment", controllerOf:_paymentController,
                      keyboard: TextInputType.number),
                   
                         
/// todo implememnt  the hidden form field for payments made when not paid on delivery

SizedBox(height: 10,), 

                        

Padding(
  padding: EdgeInsets.symmetric(horizontal:MediaQueryDataR(context).mdw(.1)),
  child:   Table(
    children: [  
    TableRow(children: [  
      Text("\nItem Delivered",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),  
              Checkbox(value: itemIsdeliver,checkColor: Colors.red,
              activeColor: Colors.white, onChanged: (retVal){

                if(widget.isAdmin == true){
            setState(() {  
              itemIsdeliver = retVal;  
            });
                }
  
      }),  
    ]),
  ]),
),
  widget.isAdmin == true?  MediaQueryDataR(context).rbutn(
            action: (){

                  
                   if(imageFile != null ){

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
            txt: "Check "                        
            ):Container(),

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
     String theUrl ="http://10.0.2.2:5000/recieveDelivery?payOnDelivery=${payment == "0.0"?"0.0":payment}&isDelivered=${itemIsdeliver == true?"yes":"no"}&theId=${widget.theId}";

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
    }

}