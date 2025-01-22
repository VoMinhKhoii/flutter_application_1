import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EducationalContentBox extends StatefulWidget {
  @override
  _EducationalContentBoxState createState() => _EducationalContentBoxState();
}

class _EducationalContentBoxState extends State<EducationalContentBox> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> _educationalContent = [
    {
      'question': 'How can I track my menstrual cycle effectively?',
      'description': 'Tracking your cycle helps you identify patterns and predict periods. Use a calendar or apps to log start dates, symptoms, and mood changes.',
    },
    {
      'question': 'What are the signs of an irregular menstrual cycle?',
      'description': 'Irregular cycles include periods shorter than 21 days, longer than 35 days, or skipped periods. Consult a doctor if irregularities persist.',
    },
    {
      'question': 'What causes hormonal imbalances in women?',
      'description': 'Stress, lifestyle, medications, or health conditions like PCOS can disrupt hormone levels. A balanced diet and regular exercise can help regulate hormones.',
    },
    {
      'question': 'How can I relieve period pain naturally?',
      'description': 'Try applying heat packs, doing gentle yoga, staying hydrated, or consuming anti-inflammatory foods like ginger and turmeric.',
    },
    {
      'question': 'When should I see a doctor about fertility issues?',
      'description': 'If you\'ve been trying to conceive for over a year without success, or six months if you\'re over 35, it\'s time to consult a specialist.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sliding Educational Content
          SizedBox(
            height: 160,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _educationalContent.length,
              itemBuilder: (context, index) {
                final content = _educationalContent[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content['question']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      content['description']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7F8C8D),
                        height: 1.5,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 16),
          // Sliding Indicator
          Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: _educationalContent.length,
              effect: WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Color(0xFF90EE90),
                dotColor: Colors.grey[300]!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
