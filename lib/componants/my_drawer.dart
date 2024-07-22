import 'package:coffee_app/pages/coffee_manager.dart';
import 'package:coffee_app/pages/login_screen.dart';
import 'package:flutter/material.dart';

import '../const.dart';
import '../pages/about_screen.dart';
import '../pages/home_screen.dart';

class MyDrawer extends StatelessWidget {
  final String? email;
  MyDrawer({this.email});
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Image.asset(
                'lib/images/espresso.png',
                height: 160,
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutScreen()));
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About'),
                  ),
                ),
              ),
              if (email == 'ruti4293@gmail.com')
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CoffeeManager()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: ListTile(
                      leading: Icon(Icons.manage_accounts),
                      title: Text('Manage Products'),
                    ),
                  ),
                ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 25, bottom: 25),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
