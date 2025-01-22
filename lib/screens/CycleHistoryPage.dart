import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/LifeStyleSymptomPage.dart';

class CycleHistoryPage extends StatefulWidget {
  const CycleHistoryPage({super.key});

  @override
  State<CycleHistoryPage> createState() => _CycleHistoryPageState();
}

class _CycleHistoryPageState extends State<CycleHistoryPage> {
  String? selectedDate;
  String? selectedPeriodLength;
  String? selectedCycleLength;
  String? selectedRegularity;

  final List<String> periodLengths = ['< 3 days', '3 - 5 days', ' 5 - 8 days', '> 8 days'];
  final List<String> cycleLengths = ['<21 days', '21–28 days', '28–30 days', '>30 days'];
  final List<String> regularityOptions = ['Yes', 'No', 'Sometimes'];

  void showDatePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: 250,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            minimumDate: DateTime(1900, 1, 1),
            maximumDate: DateTime.now(),
            onDateTimeChanged: (DateTime value) {
              setState(() {
                selectedDate =
                    "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
              });
            },
          ),
        );
      },
    );
  }

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
        title: const Text('Cycle History'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please fill in your cycle details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildFormField(
                label: 'First Day of Last Period',
                field: GestureDetector(
                  onTap: showDatePicker,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      selectedDate ?? 'Select Date',
                      style: TextStyle(
                        color: selectedDate == null ? Colors.grey : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              _buildFormField(
                label: 'Period Duration',
                field: DropdownButtonFormField<String>(
                  value: selectedPeriodLength,
                  hint: const Text('Select Duration'),
                  items: periodLengths.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPeriodLength = value;
                    });
                  },
                ),
              ),
              _buildFormField(
                label: 'Cycle Length',
                field: DropdownButtonFormField<String>(
                  value: selectedCycleLength,
                  hint: const Text('Select Length'),
                  items: cycleLengths.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCycleLength = value;
                    });
                  },
                ),
              ),
              _buildFormField(
                label: 'Regular Periods',
                field: DropdownButtonFormField<String>(
                  value: selectedRegularity,
                  hint: const Text('Select Regularity'),
                  items: regularityOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRegularity = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedDate == null ||
                        selectedPeriodLength == null ||
                        selectedCycleLength == null ||
                        selectedRegularity == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LifestyleSymptomsPage()),
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
