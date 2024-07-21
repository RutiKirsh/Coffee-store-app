import 'package:coffee_app/pages/home_screen.dart';
import 'package:flutter/material.dart';
import '../const.dart';

class IntroScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: Image.asset("lib/images/espresso.png", height: 200),
            ),
            SizedBox(height: 48,),
            Text('Brew Day',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.brown[800]),),
            SizedBox(height: 24,),
            Text('How do you like your coffee?', style: TextStyle(color: Colors.brown, fontSize: 16),),
            SizedBox(height: 48,),
            GestureDetector(
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Container(
                padding: EdgeInsets.all(25),
                margin: EdgeInsets.symmetric(horizontal: 25),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.brown[700],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('Enter Shop', textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}