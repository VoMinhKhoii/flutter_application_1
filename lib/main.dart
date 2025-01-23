import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/HomePage.dart';
import 'package:flutter_application_1/screens/TelemedicinePage.dart';
import 'package:flutter_application_1/screens/TrackerPage.dart';
//import 'screens/home_screen.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
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
      home: HomePage(),
    );
  }
}