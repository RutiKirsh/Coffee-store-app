import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyA7N6MDVpRytXHDAsWJhvB2nYo3hbl2J9I',
      appId: '1:613229674200:android:1ab547c7dc5be99a5ae1ad',
      messagingSenderId: '613229674200',
      projectId: 'coffee-app-3b397',
      storageBucket: 'coffee-app-3b397.appspot.com'
      );
}
