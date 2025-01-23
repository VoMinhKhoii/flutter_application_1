import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/MenstrualCycleDetailsPage.dart';

class LifestyleSymptomsPage extends StatefulWidget {
  const LifestyleSymptomsPage({super.key});

  @override
  State<LifestyleSymptomsPage> createState() => _LifestyleSymptomsPageState();
}

class _LifestyleSymptomsPageState extends State<LifestyleSymptomsPage> {
  final List<String> symptoms = [
    'Cramps',
    'Bloating',
    'Mood Swings',
    'Fatigue',
    'Headaches',
    'Breast Tenderness'
  ];

  List<bool> selectedSymptoms = List.generate(6, (_) => false);
  String? symptomIntensity;
  String? selectedDiet;
  String? selectedSleepDuration;
  bool exercises = false;
  double exerciseFrequency = 0;
  final TextEditingController otherDietController = TextEditingController();

  final List<String> intensityOptions = ['Mild', 'Moderate', 'Severe'];
  final List<String> dietOptions = ['Vegan', 'Vegetarian', 'Keto', 'Balanced', 'Other'];
  final List<String> sleepOptions = ['<5 hours', '5-6 hours', '6-7 hours', '7+ hours'];

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
        title: const Text('Lifestyle & Symptoms'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tell us about your lifestyle and symptoms:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildFormField(
                label: 'Symptoms During Cycle',
                field: Wrap(
                  spacing: 8.0,
                  children: List.generate(symptoms.length, (index) {
                    return FilterChip(
                      label: Text(symptoms[index]),
                      selected: selectedSymptoms[index],
                      onSelected: (bool value) {
                        setState(() {
                          selectedSymptoms[index] = value;
                        });
                      },
                    );
                  }),
                ),
              ),
              _buildFormField(
                label: 'Symptom Intensity',
                field: DropdownButtonFormField<String>(
                  value: symptomIntensity,
                  hint: const Text('Select Intensity'),
                  items: intensityOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      symptomIntensity = value!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Select Intensity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              _buildFormField(
                label: 'Diet/Lifestyle',
                field: DropdownButtonFormField<String>(
                  value: selectedDiet,
                  hint: const Text('Select Diet/Lifestyle'),
                  items: dietOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDiet = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              if (selectedDiet == 'Other')
                _buildFormField(
                  label: 'Please Specify',
                  field: TextField(
                    controller: otherDietController,
                    decoration: InputDecoration(
                      hintText: 'Enter your diet/lifestyle',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              _buildFormField(
                label: 'Typical Sleep Duration',
                field: DropdownButtonFormField<String>(
                  value: selectedSleepDuration,
                  hint: const Text('Select Sleep Duration'),
                  items: sleepOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSleepDuration = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              _buildFormField(
                label: 'Do You Exercise?',
                field: Row(
                  children: [
                    Switch(
                      value: exercises,
                      onChanged: (value) {
                        setState(() {
                          exercises = value;
                          if (!exercises) {
                            exerciseFrequency = 0;
                          }
                        });
                      },
                    ),
                    const Text('Yes'),
                  ],
                ),
              ),
              if (exercises)
                _buildFormField(
                  label: 'Frequency of Exercise (Days/Week)',
                  field: Slider(
                    value: exerciseFrequency,
                    min: 0,
                    max: 7,
                    divisions: 7,
                    label: "${exerciseFrequency.toInt()} days",
                    onChanged: (value) {
                      setState(() {
                        exerciseFrequency = value;
                      });
                    },
                  ),
                ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // if (selectedDiet == null || selectedSleepDuration == null) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text('Please complete all fields'),
                    //       backgroundColor: Colors.red,
                    //     ),
                    //   );
                    //   return;
                    // }
                    // if (selectedDiet == 'Other' &&
                    //     (otherDietController.text.isEmpty || otherDietController.text.trim().isEmpty)) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text('Please specify your diet/lifestyle'),
                    //       backgroundColor: Colors.red,
                    //     ),
                    //   );
                    //   return;
                    // }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MenstrualCycleDetailsPage()),
                    );
                    print('Next button pressed');
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
