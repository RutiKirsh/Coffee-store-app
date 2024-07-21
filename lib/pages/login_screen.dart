import 'package:coffee_app/componants/my_button.dart';
import 'package:coffee_app/componants/my_text_feild.dart';
import 'package:coffee_app/services/email_service.dart';
import 'package:coffee_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../const.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  int _selectedIndex = 0;
  bool flag = false;
  final List options = ['Email', 'Phone'];
  TextEditingController _emailUser = TextEditingController();
  TextEditingController _phoneUser = TextEditingController(text: '+972-');
  TextEditingController _code = TextEditingController();
  late TextEditingController controller;


  String code = '123456';
  FocusNode _focusNode = FocusNode();
  final UserService userService = UserService();

  void navigatorBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
String generateCode(){
    return (100000 + (999999 - 100000) * (new DateTime.now().millisecondsSinceEpoch % 1000)).toString(); 
  }
  bool verify() {
    return _code.text == code;
  }

  Widget changeTextField(int index) {
    String option = options[index];
    String text;
    if (option == 'Email') {
      text = 'Send me verification code to my email';
      controller = _emailUser;
    } else {
      text = 'Send me verification code';
      controller = _phoneUser;
    }
    return Column(children: [
      SizedBox(
        height: 10,
      ),
      MyTextField(
        controller: controller,
        hintText: options[index],
        obscureText: false,
        focusNode: _focusNode,
      ),
      SizedBox(
        height: 15,
      ),
      flag
          ? Center(
              child: Text(
                'We sent you a verification code, to your email: ${controller.text}',
              ),
            )
          : GestureDetector(
              onTap: () {
                // code = generateCode();
                code = '123456';
                sendVerificationCode(controller.text, code);
                setState(() {
                  flag = true;
                });
              },
              child: Container(
                padding: EdgeInsets.all(25),
                margin: EdgeInsets.symmetric(horizontal: 25),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.brown[700],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
    ]);
  }

  Widget loginButton(void Function(int)? onTabChange) {
    return Container(
      margin: EdgeInsets.all(25),
      child: GNav(
        onTabChange: onTabChange,
        color: Colors.grey[400],
        activeColor: Colors.grey[700],
        tabBorderRadius: 24,
        tabBackgroundColor: Colors.grey.shade300,
        tabActiveBorder: Border.all(color: Colors.white),
        gap: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        tabs: [
          GButton(icon: Icons.email, text: 'Email'),
          GButton(icon: Icons.phone, text: 'Phone'),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: Image.asset("lib/images/latte.png", height: 100),
            ),
            SizedBox(
              height: 48,
            ),
            Text(
              'Hi, welcome!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.brown[800]),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'Enter your email or phone number to enter',
              style: TextStyle(color: Colors.brown, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            loginButton(navigatorBottomBar),
            changeTextField(_selectedIndex),
            SizedBox(
              height: 10,
            ),
            flag
                ? Column(children: [
                    MyTextField(
                      controller: _code,
                      hintText: 'Code',
                      obscureText: false,
                      focusNode: _focusNode,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        verify()
                            ?{ Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen(email: _emailUser.text))),
                                    userService.addUser(controller.text)
                            }: ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Invalid code')));
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.brown[700],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Verify',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ])
                : Container(),
          ],
        ),
      ),
    );
  }
}
