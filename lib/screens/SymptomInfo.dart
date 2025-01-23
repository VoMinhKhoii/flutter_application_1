import 'package:flutter/material.dart';

class SymptomsScreen extends StatefulWidget {
  final DateTime selectedDate;

  const SymptomsScreen({
    super.key,
    required this.selectedDate,
  });

  @override
  State<SymptomsScreen> createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  bool _hasPeriod = false;
  int _flowIntensity = 1;
  final List<String> _selectedSymptoms = [];
  final TextEditingController _notesController = TextEditingController();
  
  // New fields for menstrual products
  final List<bool> _selectedProducts = List.generate(5, (_) => false);
  final TextEditingController _otherProductController = TextEditingController();

  // List of menstrual products
  final List<String> _products = [
    'Pads',
    'Tampons',
    'Menstrual Cup',
    'Panty Liners',
    'Other'
  ];

  // Predefined lists of symptoms by category with colors
  final Map<String, Map<String, dynamic>> _symptomCategories = {
    'Pain': {
      'color': Color(0xFFFFE8D6),
      'icon': Icons.healing,
      'symptoms': [
        'Cramps',
        'Headache',
        'Back pain',
        'Breast tenderness',
        'Joint pain',
      ],
    },
    'Mood': {
      'color': Color(0xFFE0F4FF),
      'icon': Icons.mood,
      'symptoms': [
        'Anxious',
        'Depressed',
        'Irritable',
        'Mood swings',
        'Stressed',
      ],
    },
    'Physical': {
      'color': Color(0xFFE8FFE0),
      'icon': Icons.favorite,
      'symptoms': [
        'Bloating',
        'Fatigue',
        'Acne',
        'Nausea',
        'Dizziness',
        'Food cravings',
        'Insomnia',
      ],
    },
  };

  // Method to build menstrual products section
  Widget _buildMenstrualProductsSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Menstrual Products',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple[800],
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                _products.length,
                (index) => FilterChip(
                  label: Text(_products[index]),
                  selected: _selectedProducts[index],
                  selectedColor: Colors.purple[100],
                  checkmarkColor: Colors.purple[800],
                  onSelected: (bool value) {
                    setState(() {
                      _selectedProducts[index] = value;
                      // Clear other product text if 'Other' is deselected
                      if (!_selectedProducts[4]) {
                        _otherProductController.clear();
                      }
                    });
                  },
                ),
              ),
            ),
            // Conditional text field for 'Other' product
            if (_selectedProducts[4]) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _otherProductController,
                decoration: InputDecoration(
                  labelText: 'Specify Other Product',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.purple[800]!),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How are you feeling?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}',
              style: TextStyle(fontSize: 14, color: Colors.green[800]),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Section with Gradient
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink[50]!, Colors.pink[100]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Period',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          value: _hasPeriod,
                          activeColor: Colors.pink[400],
                          onChanged: (value) {
                            setState(() {
                              _hasPeriod = value;
                            });
                          },
                        ),
                      ],
                    ),
                    if (_hasPeriod) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'How heavy is your flow today?',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          5,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _flowIntensity = index + 1;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _flowIntensity == index + 1
                                    ? Colors.pink[400]
                                    : Colors.white.withOpacity(0.9),
                                boxShadow: [
                                  if (_flowIntensity == index + 1)
                                    BoxShadow(
                                      color: Colors.pink.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    ),
                                ],
                              ),
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  color: _flowIntensity == index + 1
                                      ? Colors.white
                                      : Colors.pink[400],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Menstrual Products Section
            _buildMenstrualProductsSection(),

            // Symptoms Categories
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _symptomCategories.length,
              itemBuilder: (context, index) {
                final category = _symptomCategories.keys.elementAt(index);
                final categoryData = _symptomCategories[category]!;
                final symptoms = categoryData['symptoms'] as List<String>;
                final color = categoryData['color'] as Color;
                final icon = categoryData['icon'] as IconData;

                return Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(icon, color: Colors.grey[800]),
                            const SizedBox(width: 8),
                            Text(
                              category,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: symptoms.map((symptom) {
                            final isSelected = _selectedSymptoms.contains(symptom);
                            return FilterChip(
                              label: Text(symptom),
                              selected: isSelected,
                              selectedColor: Colors.white.withOpacity(0.9),
                              backgroundColor: Colors.white.withOpacity(0.5),
                              checkmarkColor: Colors.green[800],
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    _selectedSymptoms.add(symptom);
                                  } else {
                                    _selectedSymptoms.remove(symptom);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Notes
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Notes',
                    labelStyle: TextStyle(color: Colors.green[800]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.green[800]!),
                    ),
                    hintText: 'Add any additional notes here...',
                  ),
                ),
              ),
            ),

            // Save Button
            Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  final healthData = {
                    'date': widget.selectedDate,
                    'hasPeriod': _hasPeriod,
                    'flowIntensity': _hasPeriod ? _flowIntensity : null,
                    'menstrualProducts': _selectedProducts.asMap().entries
                        .where((entry) => entry.value)
                        .map((entry) => _products[entry.key])
                        .toList(),
                    'otherProduct': _otherProductController.text,
                    'symptoms': _selectedSymptoms,
                    'notes': _notesController.text,
                  };
                  Navigator.of(context).pop(healthData);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    _otherProductController.dispose();
    super.dispose();
  }
}