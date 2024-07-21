import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget{
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About', style: TextStyle(color: Colors.grey.shade900),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        ),
      body:Center( 
        child:Text('We have great coffee'),
        ),
    );
  }
}