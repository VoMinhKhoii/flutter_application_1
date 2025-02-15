import 'package:flutter/material.dart';
import 'package:flutter_application_1/ai_chat/ChatPage.dart';
import 'package:flutter_application_1/screens/TrackerPage.dart';
import 'package:flutter_application_1/screens/TelemedicinePage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'EducationalContentBox.dart';
import 'RewardModule.dart';
import 'EducationalModule.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    // Navigate based on index
    switch(index) {
      case 0: // Home
        break;
      case 1: // Tracker
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrackerPage()),
        );
        break;
      case 2: // Medical
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TelemedicinePage()),
        );
        break;
      case 3: // Profile
        // Uncomment and implement ProfilePage when ready
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ProfilePage()),
        // );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App Bar
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: 0,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.green[100]!,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40), // Balance with notification icon width
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset('assets/logo.png', height: 52),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none),
                      onPressed: () {
                        // Placeholder for notification button
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          
          // Expanded ListView for Scrollable Content
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
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

                // Doctor Availability Box
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.green[50], // Green background
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.portrait_rounded,
                        color: Colors.green,
                        size: 32,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Doctor Availability',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Dr. ABC is available for online consultations today.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Reward Module
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: RewardModule(totalTokens: 0),
                ),

                SizedBox(height: 16),

                // Educational Module
                Container(
                  height: 400,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: EducationalModule(
                    onVideoCompleted: (tokens) {
                      print('Tokens earned: $tokens');
                    },
                  ),
                ),

                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[100],
        elevation: 4,
        child: const Icon(Icons.chat_outlined, color: Colors.blue, size: 28),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatPage()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_filled, 'Home', Colors.green[800]!, 0),
              _buildNavItem(Icons.calendar_month_outlined, 'Tracker', Colors.grey, 1),
              const SizedBox(width: 40),
              _buildNavItem(Icons.medical_services_outlined, 'Medical', Colors.grey, 2),
              _buildNavItem(Icons.account_circle, 'Profile', Colors.grey, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, Color color, int index) {
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: SizedBox(
          height: 56,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: _selectedIndex == index ? Colors.green[800] : color,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: _selectedIndex == index ? Colors.green[800] : color,
                  fontSize: 11,
                  height: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}