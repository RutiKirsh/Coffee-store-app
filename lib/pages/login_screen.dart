import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/componants/my_button.dart';
import 'package:coffee_app/componants/my_text_feild.dart';
import 'package:coffee_app/services/email_service.dart';
import 'package:coffee_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  bool _isCodeSent = false;
  final List options = ['Email', 'Phone'];
  TextEditingController _emailUser = TextEditingController();
  TextEditingController _phoneUser = TextEditingController(text: '+972-');
  TextEditingController _code = TextEditingController();
  String? _verificationid;
  late TextEditingController controller;

  String code = '';
  FocusNode _focusNode = FocusNode();
  final UserService userService = UserService();

  void navigatorBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String generateCode() {
    String code = '';
    for (int i = 0; i < 6; i++) {
      code += (0 + (Random().nextInt(9))).toString();
    }
    return code;
  }

  void _signInSMSCode() async {
    if (_verificationid != null) {
      final credential = PhoneAuthProvider.credential(
          verificationId: _verificationid!, smsCode: _code.text);
      await FirebaseAuth.instance.signInWithCredential(credential);
      _checkIfNewUser();
    }
  }

  void _verifyPhoneNumber() async {
    String phoneNumber = _phoneUser.text.trim();
    if (!phoneNumber.startsWith('+')) {
      phoneNumber = '+972' + phoneNumber;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        _checkIfNewUser();
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Vari failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationid = verificationId;
          _isCodeSent = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void _sendVerificationEmail() async {
    String email = _emailUser.text.trim();
    if (email.isEmpty ||
        !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a valid email address.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void _checkIfNewUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot userDocs = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: _emailUser.text.trim())
          .get();
      if (userDocs.docs.isEmpty) {
        registerNewUser();
      } else {
        _navigateToHome();
      }
    }
  }

  void registerNewUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
        'name': _emailUser.text.trim(),
        'phone': _phoneUser.text.trim(),
        'email': _emailUser.text.trim(),
      });
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  email: _emailUser.text.trim(),
                )));
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
      options[0]=='Email'?
      _isCodeSent
          ? Center(
              child: Text(
                'We sent you a verification code, to your email: ${controller.text}',
              ),
            )
          : GestureDetector(
              onTap: () {
                code = generateCode();
                // code = '123456';
                sendVerificationCode(controller.text, code);
                setState(() {
                  _isCodeSent = true;
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
            ): 
            _isCodeSent
          ? Center(
              child: Text(
                'We sent you a verification code, to your phone: ${controller.text}',
              ),
            )
          : GestureDetector(
              onTap: () {
                code = generateCode();
                _verifyPhoneNumber();
                // code = '123456';
                sendVerificationCode(controller.text, code);
                setState(() {
                  _isCodeSent = true;
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
            )
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
            _isCodeSent
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
                            ? {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen(
                                            email: _emailUser.text))),
                                userService.addUser(controller.text)
                              }
                            : ScaffoldMessenger.of(context).showSnackBar(
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
