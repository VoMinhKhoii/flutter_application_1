import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'EducationalContentBox.dart';


void main() {
  runApp(const VnHopeApp());
}

class VnHopeApp extends StatelessWidget {
  const VnHopeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VnHOPE',
      theme: ThemeData(
        primaryColor: Color(0xFF90EE90),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'SF Pro Display',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Color(0xFF90EE90),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset('assets/logo.png', height: 28),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'VnHOPE',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.notifications_none, 
                      color: Color(0xFF2C3E50),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            
            // Greeting Card
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                'Hi Y! How are you feeling today?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),

            // Educational Content Box
            EducationalContentBox(),
            
            // Calendar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
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
              child: TableCalendar(
                firstDay: DateTime.utc(2022, 1, 1),
                lastDay: DateTime.utc(2022, 12, 31),
                focusedDay: DateTime.utc(2022, 1, 1),
                calendarFormat: CalendarFormat.week,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFF2C3E50)),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFF2C3E50)),
                ),
                selectedDayPredicate: (day) => 
                  day.day == 1 && day.month == 1 && day.year == 2022,
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFF1ABC9C),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Color(0xFF90EE90).withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: TextStyle(color: Color(0xFFE74C3C)),
                ),
              ),
            ),

            Spacer(),

            // Bottom Navigation Bar
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home_rounded, 'Home', true),
                  _buildNavItem(Icons.calendar_today_rounded, 'Period tracker', false),
                  _buildNavItem(Icons.video_call_rounded, 'Telemedicine', false),
                  _buildNavItem(Icons.person_rounded, 'Profile', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF90EE90).withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isSelected ? Color(0xFF2C3E50) : Color(0xFF95A5A6),
            size: 24,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? Color(0xFF2C3E50) : Color(0xFF95A5A6),
          ),
        ),
      ],
    );
  }
}