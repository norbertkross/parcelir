import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MediaQueryDataR{
MediaQueryDataR(this.context);
 BuildContext context;

// get the dimensions of the devise
 double mdw(double pcnt)=>MediaQuery.of(context).size.width*pcnt;
 double mdh(double pcnt)=> MediaQuery.of(context).size.height*pcnt;

 // check device orientation
 ornt()=> MediaQuery.of(context).orientation == Orientation.portrait? true:false;

  Widget rbutn ({String txt,Color txtCol,Color btcol,Function action}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoButton(
        color: btcol != null?btcol:Colors.red,
        borderRadius: BorderRadius.circular(30),
        child:Text( txt != null?txt:"Report",
        style: TextStyle(color:txtCol !=null?txtCol:Colors.white),),
         onPressed:action != null?action:null,
         ),
    );
  }
}
