import 'package:coffee_app/firebase_option.dart';
import 'package:coffee_app/models/coffee_shop.dart';
import 'package:coffee_app/pages/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(/*options: DefaultFirebaseOptions.currentPlatform*/);
  //לcollection פוקציה לדחיפת כל הנתונים בפעם הראשונה 
  // await CoffeeShop.addCoffeeToFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (context) => CoffeeShop(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),

    );
  }
}