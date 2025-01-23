import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/AccessibilityAndEcoFriendlyPage.dart';

class FertilityAndProductUsagePage extends StatefulWidget {
  const FertilityAndProductUsagePage({super.key});

  @override
  State<FertilityAndProductUsagePage> createState() =>
      _FertilityAndProductUsagePageState();
}

class _FertilityAndProductUsagePageState
    extends State<FertilityAndProductUsagePage> {
  bool tryingToConceive = false;
  bool trackOvulation = false;
  String? ovulationMethod;
  String? otherOvulationMethod; // Added for "Other" option
  List<bool> selectedProducts = List.generate(5, (_) => false);
  final List<String> products = [
    'Pads',
    'Tampons',
    'Menstrual Cup',
    'Reusable Pads',
    'Other'
  ];
  final List<String> ovulationMethods = [
    'Basal Temperature',
    'Ovulation Kit',
    'Cervical Mucus',
    'Other'
  ];

  final TextEditingController otherProductController = TextEditingController();
  final TextEditingController otherOvulationController =
      TextEditingController(); // Added controller for "Other" ovulation method

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
        title: const Text('Fertility & Product Usage'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tell us about your fertility and product preferences:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildFormField(
                label: 'Are you currently trying to conceive?',
                field: Row(
                  children: [
                    Switch(
                      value: tryingToConceive,
                      onChanged: (value) {
                        setState(() {
                          tryingToConceive = value;
                        });
                      },
                    ),
                    Text(tryingToConceive ? 'Yes' : 'No'),
                  ],
                ),
              ),
              _buildFormField(
                label: 'Do you track ovulation?',
                field: Row(
                  children: [
                    Switch(
                      value: trackOvulation,
                      onChanged: (value) {
                        setState(() {
                          trackOvulation = value;
                          if (!trackOvulation) {
                            ovulationMethod = null;
                            otherOvulationController.clear();
                          }
                        });
                      },
                    ),
                    Text(trackOvulation ? 'Yes' : 'No'),
                  ],
                ),
              ),
              if (trackOvulation)
                _buildFormField(
                  label: 'How do you track ovulation?',
                  field: DropdownButtonFormField<String>(
                    value: ovulationMethod,
                    hint: const Text('Select a method'),
                    items: ovulationMethods.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        ovulationMethod = value;
                        if (value != 'Other') {
                          otherOvulationController.clear();
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
              if (trackOvulation && ovulationMethod == 'Other')
                _buildFormField(
                  label: 'Please specify your ovulation method',
                  field: TextField(
                    controller: otherOvulationController,
                    decoration: InputDecoration(
                      hintText: 'Enter your ovulation method',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              _buildFormField(
                label: 'What menstrual products do you primarily use?',
                field: Wrap(
                  spacing: 8.0,
                  children: List.generate(products.length, (index) {
                    return FilterChip(
                      label: Text(products[index]),
                      selected: selectedProducts[index],
                      onSelected: (bool value) {
                        setState(() {
                          selectedProducts[index] = value;
                          if (!selectedProducts[4]) {
                            otherProductController.clear();
                          }
                        });
                      },
                    );
                  }),
                ),
              ),
              if (selectedProducts[4])
                _buildFormField(
                  label: 'Please specify your product',
                  field: TextField(
                    controller: otherProductController,
                    decoration: InputDecoration(
                      hintText: 'Enter product name',
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
                  onPressed: () {
                    // if (trackOvulation &&
                    //     ovulationMethod == 'Other' &&
                    //     otherOvulationController.text.trim().isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text(
                    //           'Please specify your "Other" ovulation method'),
                    //       backgroundColor: Colors.red,
                    //     ),
                    //   );
                    //   return;
                    // }
                    // if (selectedProducts[4] &&
                    //     otherProductController.text.trim().isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text(
                    //           'Please specify your "Other" menstrual product'),
                    //       backgroundColor: Colors.red,
                    //     ),
                    //   );
                    //   return;
                    // }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AccessibilityAndEcoFriendlyPage()),
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

  @override
  void dispose() {
    otherProductController.dispose();
    otherOvulationController.dispose(); // Dispose of additional controller
    super.dispose();
  }
}
