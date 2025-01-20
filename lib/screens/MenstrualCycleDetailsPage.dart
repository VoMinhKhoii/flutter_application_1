// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/FertilityAndProductUsagePage.dart';

class MenstrualCycleDetailsPage extends StatefulWidget {
  const MenstrualCycleDetailsPage({super.key});

  @override
  State<MenstrualCycleDetailsPage> createState() =>
      _MenstrualCycleDetailsPageState();
}

class _MenstrualCycleDetailsPageState
    extends State<MenstrualCycleDetailsPage> {
  String? irregularCycles;
  String? spottingBetweenPeriods;
  String? periodFlow;
  bool diagnosedDisorders = false;
  String? selectedDisorder;

  final List<String> cycleOptions = ['Yes', 'No', 'Sometimes'];
  final List<String> flowIntensity = ['Light', 'Medium', 'Heavy', 'Very Heavy'];
  final List<String> disorders = [
    'PCOS - few, unusual or very long periods',
    'Abnormal menstrual bleeding',
    'Absence of menstrual bleeding',
    'Premenstrual dysphonic disorder (PMDD)',
    'Other'
  ];

  final TextEditingController otherDisorderController =
      TextEditingController();

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

  void validateAndNavigate() {
    if (irregularCycles == null ||
        spottingBetweenPeriods == null ||
        periodFlow == null ||
        (diagnosedDisorders &&
            selectedDisorder == null) || // Check if a disorder is selected
        (diagnosedDisorders &&
            selectedDisorder == 'Other' &&
            otherDisorderController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FertilityAndProductUsagePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menstrual Cycle Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tell us more about your menstrual cycle:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildFormField(
                label: 'Do you experience irregular cycles?',
                field: DropdownButtonFormField<String>(
                  value: irregularCycles,
                  hint: const Text('Select an option'),
                  items: cycleOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      irregularCycles = value;
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
                label: 'Do you experience spotting between periods?',
                field: DropdownButtonFormField<String>(
                  value: spottingBetweenPeriods,
                  hint: const Text('Select an option'),
                  items: cycleOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      spottingBetweenPeriods = value;
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
                label: 'How intense is your period flow usually?',
                field: DropdownButtonFormField<String>(
                  value: periodFlow,
                  hint: const Text('Select Flow Intensity'),
                  items: flowIntensity.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      periodFlow = value;
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
                label: 'Have you been diagnosed with any menstrual disorders?',
                field: Row(
                  children: [
                    Switch(
                      value: diagnosedDisorders,
                      onChanged: (value) {
                        setState(() {
                          diagnosedDisorders = value;
                          if (!diagnosedDisorders) {
                            selectedDisorder = null;
                            otherDisorderController.clear();
                          }
                        });
                      },
                    ),
                    const Text('Yes'),
                  ],
                ),
              ),
              if (diagnosedDisorders)
                _buildFormField(
                  label: 'Specify the disorder',
                  field: DropdownButtonFormField<String>(
                    value: selectedDisorder,
                    hint: const Text('Select a disorder'),
                    items: disorders.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDisorder = value;
                        if (value != 'Other') {
                          otherDisorderController.clear();
                        }
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              if (diagnosedDisorders && selectedDisorder == 'Other')
                _buildFormField(
                  label: 'Please specify your condition',
                  field: TextField(
                    controller: otherDisorderController,
                    decoration: InputDecoration(
                      hintText: 'Enter your condition',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: validateAndNavigate,
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

  @override
  void dispose() {
    otherDisorderController.dispose();
    super.dispose();
  }
}
