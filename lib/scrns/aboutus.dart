import 'package:flutter/material.dart';

class About extends StatefulWidget {
  final bool isAbout;
  About({this.isAbout});
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parcelir"),
        centerTitle: true,
      ),
      body: Center(
        child: widget.isAbout == true? Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("This Is Parcelir. We offer parcel delivery services through VIP buses",
          style: TextStyle(color: Colors.red),),
        ):Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("\n Email: norbertaberor@gmail.com\n Contact: +233(0) 557340556",
          style: TextStyle(color: Colors.red),),
        ),
      ),
    );
  }
}