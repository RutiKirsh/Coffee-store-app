import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendEmail(String email, String subject, String text) async {
  String username = 'ohadleib@gmail.com';
  String password = 'bcep gayq pxzx oxkf';

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'Coffee app')
    ..recipients.add(email)
    ..subject = subject
    ..text = text;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}

Future<void> sendVerificationCode(String email, String code) async{
 await sendEmail(email, 'Verification Code', 'Your verification code is: $code');

}

Future<void> sendOrderEmail(String email, String order, String total) async{
await sendEmail(email, 'Your order:', 'Details: ${order}, Toaal: $total');


}