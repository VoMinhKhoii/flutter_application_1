import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/BasicInfoPage.dart';
//import 'screens/home_screen.dart';

void main() {
  runApp(VnHopeApp());
}

class VnHopeApp extends StatelessWidget {
  const VnHopeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VnHOPE',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      //home: HomeScreen(), // Default screen
      home: BasicInfoApp(),
    );
  }
}
