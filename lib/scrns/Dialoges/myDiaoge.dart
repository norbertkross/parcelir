import 'package:flutter/material.dart';


class BaseAlertDialog extends StatelessWidget {

  //When creating please recheck 'context' if there is an error!

  Color _color = Color.fromARGB(220, 117, 218 ,255);

  String _title;
  String _content;
  String _yes;
  String _no;
  Function _yesOnPressed;
  Function _noOnPressed;

  BaseAlertDialog({String title, String content, Function yesOnPressed, Function noOnPressed, String yes = "Yes", String no = "No"}){
    this._title = title;
    this._content = content;
    this._yesOnPressed = yesOnPressed;
    this._noOnPressed = noOnPressed;
    this._yes = yes;
    this._no = no;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(.7),
        body: AlertDialog(
          title: Text(this._title,style: TextStyle(color: Colors.blueGrey.withOpacity(.5)),),
          content: Text(this._content),
          backgroundColor: this._color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          actions: <Widget>[
             FlatButton(
              child: Text(this._yes),
              textColor: Colors.redAccent,
              onPressed: () {
                this._yesOnPressed();
              },
            ),
          ],
        ),
      ),
    );
  }
}