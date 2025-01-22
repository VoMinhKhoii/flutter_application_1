import 'package:flutter/material.dart';
import 'package:flutter_application_1/ai_chat/ChatPage.dart';
import 'package:flutter_application_1/screens/greeting.dart';
//import 'screens/home_screen.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/const.dart';

void main() {
  runApp(VnHopeApp());
}

class VnHopeApp extends StatelessWidget {
  const VnHopeApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(OPENAI_API_KEY);
    return MaterialApp(
      title: 'VnHOPE',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      //home: HomeScreen(), // Default screen
      home: ChatPage(),

    );
  }
}
