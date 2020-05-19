import 'package:flutter/material.dart';
import 'package:parcelir/introscreen.dart';
import 'package:parcelir/scrns/logins/loginBody.dart';
import 'package:parcelir/scrns/logins/loginPage.dart';
import 'package:parcelir/scrns/missingPerson.dart';
import 'package:parcelir/scrns/mytransac.dart';
import 'package:parcelir/scrns/recievingScreen.dart';
import 'package:parcelir/scrns/sendingScreen.dart';
import 'package:parcelir/scrns/viewItemsDetails.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcelir',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: 
      IntroScreen()
      //MissingPerson()
      //MyItems()
      //SendingDetails()
      //RecievingScreen()
    );
  }
}





// class TestSocketIO extends StatefulWidget {
//   @override
//   _TestSocketIOState createState() => _TestSocketIOState();
// }

// class _TestSocketIOState extends State<TestSocketIO> {


// // SocketIOManager manager = SocketIOManager();

// // sockconnect()async{
// //     SocketIO socket = await manager.createInstance(
// //     SocketOptions('http://127.0.0.1:3000', //TODO change the port  accordingly
// //         //nameSpace: '/yournamespace',
// //         enableLogging: true,
// //         transports: [Transports.POLLING])
// //     );
// //          //TODO change the port  accordingly
// //     socket.onConnect((data){
// //       print("connected...");
// //       print(data);
// //       socket.emit("message", ["Hello world!"]);
// //     });
// //     socket.on("news", (data){   //sample event
// //       print("news");
// //       print(data);
// //     });
// //     socket.connect();  
// // }

// fn(){
//   socket.connect().connected??print("yes connected");
//     socket.on('connection', (_) {
//      print('connect');
//      socket.emit('msg', 'test');
//     });  
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             SizedBox(height: 100,),
//             Text("Hello der!"),

//             RaisedButton(onPressed: (){
//              // sockconnect();
//              print("going...\n");
//              fn();
//               },child: Text("connect 1.0"),)
//           ],
//         ),
//       ),
//     );
//   }
// }