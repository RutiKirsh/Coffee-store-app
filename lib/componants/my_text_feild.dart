import 'package:coffee_app/const.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;

  const MyTextField({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.focusNode,
  });

  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.brown),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.brown,),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: backgroundColor,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.brown,)
        ),
      ),
    );
  }
}