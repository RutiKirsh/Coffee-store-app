import 'package:cloud_firestore/cloud_firestore.dart';

class UserService{
  final _firestore = FirebaseFirestore.instance;

  Future<void> addUser(userEmail) async{
    try{
     await _firestore.collection('Users').doc(userEmail).set({'userIdentifier' : userEmail});
    }catch(e){
      print('===================================');
      print(e);
    }

  }













}