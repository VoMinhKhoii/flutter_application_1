import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/HomePage.dart';

class LongTermHealthInsightsPage extends StatefulWidget {
  const LongTermHealthInsightsPage({super.key});

  @override
  State<LongTermHealthInsightsPage> createState() =>
      _LongTermHealthInsightsPageState();
}

class _LongTermHealthInsightsPageState
    extends State<LongTermHealthInsightsPage> {
  List<bool> selectedGoals = List.generate(4, (_) => false);
  final List<String> goals = [
    'Predict my cycle',
    'Manage symptoms',
    'Improve fertility awareness',
    'Understand hormonal health'
  ];

  bool familyHistory = false;
  bool approachingMenopause = false;
  bool chronicHealthConditions = false;

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
        title: const Text('Long-Term Health Insights'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Share your long-term health goals and insights:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildFormField(
                label: 'What is your primary goal in using this app?',
                field: Wrap(
                  spacing: 8.0,
                  children: List.generate(goals.length, (index) {
                    return FilterChip(
                      label: Text(goals[index]),
                      selected: selectedGoals[index],
                      onSelected: (bool value) {
                        setState(() {
                          selectedGoals[index] = value;
                        });
                      },
                    );
                  }),
                ),
              ),
              _buildFormField(
                label: 'Do you have a family history of reproductive health issues?',
                field: Row(
                  children: [
                    Switch(
                      value: familyHistory,
                      onChanged: (value) {
                        setState(() {
                          familyHistory = value;
                        });
                      },
                    ),
                    Text(familyHistory ? 'Yes' : 'No'),
                  ],
                ),
              ),
              _buildFormField(
                label: 'Are you approaching menopause or experiencing symptoms?',
                field: Row(
                  children: [
                    Switch(
                      value: approachingMenopause,
                      onChanged: (value) {
                        setState(() {
                          approachingMenopause = value;
                        });
                      },
                    ),
                    Text(approachingMenopause ? 'Yes' : 'No'),
                  ],
                ),
              ),
              _buildFormField(
                label: 'Do you experience any chronic health conditions that affect your cycle?',
                field: Row(
                  children: [
                    Switch(
                      value: chronicHealthConditions,
                      onChanged: (value) {
                        setState(() {
                          chronicHealthConditions = value;
                        });
                      },
                    ),
                    Text(chronicHealthConditions ? 'Yes' : 'No'),
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
                        builder: (context) => const HomePage(), // Replace with the next page
                      ),
                    );
                    // Perform validations if needed
                    print('Finish button pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Finish',
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
