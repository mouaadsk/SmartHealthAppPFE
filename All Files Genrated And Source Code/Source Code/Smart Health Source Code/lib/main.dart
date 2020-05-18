import 'package:flutter/material.dart';
import 'package:smarthealth/LoginPage.dart';
import 'package:smarthealth/FireAuth.dart';
import 'package:smarthealth/RootPage.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart App',
      color: Colors.white,
      home: RootPage(auth: FireAuth(),),
    );
  }
}








