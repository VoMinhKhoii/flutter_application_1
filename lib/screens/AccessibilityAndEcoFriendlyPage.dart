import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/LongTermHealthInsightsPage.dart';

class AccessibilityAndEcoFriendlyPage extends StatefulWidget {
  const AccessibilityAndEcoFriendlyPage({super.key});

  @override
  State<AccessibilityAndEcoFriendlyPage> createState() =>
      _AccessibilityAndEcoFriendlyPageState();
}

class _AccessibilityAndEcoFriendlyPageState
    extends State<AccessibilityAndEcoFriendlyPage> {
  bool accessToProducts = false;
  bool ecoFriendlyInterest = false;
  bool discomfortFromProducts = false;

  Widget _buildFormField({
    required String label,
    required Widget field,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 8),
        field,
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessibility & Eco-Friendliness'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tell us about your product accessibility and preferences:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildFormField(
                label: 'Do you have easy access to menstrual hygiene products?',
                field: Row(
                  children: [
                    Switch(
                      value: accessToProducts,
                      onChanged: (value) {
                        setState(() {
                          accessToProducts = value;
                        });
                      },
                    ),
                    Text(accessToProducts ? 'Yes' : 'No'),
                  ],
                ),
              ),
              _buildFormField(
                label: 'Are you interested in eco-friendly menstrual product options?',
                field: Row(
                  children: [
                    Switch(
                      value: ecoFriendlyInterest,
                      onChanged: (value) {
                        setState(() {
                          ecoFriendlyInterest = value;
                        });
                      },
                    ),
                    Text(ecoFriendlyInterest ? 'Yes' : 'No'),
                  ],
                ),
              ),
              _buildFormField(
                label:
                    'Have you ever experienced discomfort or irritation from your menstrual products?',
                field: Row(
                  children: [
                    Switch(
                      value: discomfortFromProducts,
                      onChanged: (value) {
                        setState(() {
                          discomfortFromProducts = value;
                        });
                      },
                    ),
                    Text(discomfortFromProducts ? 'Yes' : 'No'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LongTermHealthInsightsPage(), // Replace with the next page
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
