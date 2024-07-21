import 'package:coffee_app/componants/bottom_navbar.dart';
import 'package:coffee_app/componants/my_drawer.dart';
import 'package:coffee_app/const.dart';
import 'package:coffee_app/pages/cart_screen.dart';
import 'package:coffee_app/pages/shop_screen.dart';
import 'package:flutter/material.dart';

import '../componants/coffee_tile.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? email;
  HomeScreen({this.email});
  State<HomeScreen> createState() => _HomeScreenState(email: email);
}

class _HomeScreenState extends State<HomeScreen> {
  final String? email;
  int _selectedIndex = 0;
  _HomeScreenState({this.email});


  void navigatorBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    ShopScreen(),
    CartScreen(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: MyBottomNavBar(onTabChange: navigatorBottomBar),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Padding(
              padding: EdgeInsets.all(14),
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: MyDrawer(email: email,),
      body: _pages[_selectedIndex],
    );
  }
}
