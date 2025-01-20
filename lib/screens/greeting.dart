import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart'; // Import the LoginPage

class GreetingPage extends StatelessWidget {
  const GreetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Make status bar transparent
      statusBarIconBrightness: Brightness.dark, // Dark icons
      statusBarBrightness: Brightness.light, // For iOS
    ));
    
    return Scaffold(
      backgroundColor: Colors.teal[50], // Light teal background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App logo or illustration
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                child: Icon(Icons.health_and_safety, size: 80, color: Colors.teal),
              ),
              SizedBox(height: 20),
              // App title
              Text(
                'VnHOPE',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              SizedBox(height: 8),
              // App tagline
              Text(
                'Empowering Women\'s Health',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.teal[600],
                ),
              ),
              SizedBox(height: 24),
              // Welcome message
              Text(
                'Welcome!\nLog your health, get AI insights, and access expert care anytime, anywhere.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal[700],
                ),
              ),
              SizedBox(height: 40),
              // Buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to Login Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Log In',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  // Navigate to Sign Up (Placeholder Action)
                  print('Sign Up tapped');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.teal, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
              ),
              Spacer(),
              // Footer
              Text(
                'Your Privacy. Your Health. Our Priority.',
                style: TextStyle(
                  fontSize: 14, 
                  color: Colors.teal[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
