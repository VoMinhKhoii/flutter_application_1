import 'package:flutter/material.dart';
import 'package:flutter_application_1/ai_chat/ChatPage.dart';
import 'package:flutter_application_1/screens/HomePage.dart';
import 'package:flutter_application_1/screens/TelemedicinePage.dart';
import 'package:intl/intl.dart';
import 'SymptomInfo.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  final DateTime _currentDate = DateTime.now();
  final List<int> _periodDays = [19, 20, 21, 22, 23, 24]; // Example period days
  final List<int> _symptomsLoggedDays = [5, 6, 7, 8]; // Days with logged symptoms
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;
    int _selectedIndex = 0;  // Track selected nav item


    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    // Navigate based on index
    switch(index) {
      case 0: // Home
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1: // Tracker
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => TrackerPage()),
        // );
        break;
      case 2: // Medical
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TelemedicinePage()),
        );
        break;
      case 3: // Profile
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ProfilePage()),
        // );
        // break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Custom app bar with gradient background
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

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Calendar Section
                      Container(
                        padding: const EdgeInsets.all(20),
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
                        child: Column(
                          children: [
                            // Month Navigation
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.chevron_left),
                                  onPressed: () {
                                    setState(() {
                                      if (_selectedMonth == 1) {
                                        _selectedMonth = 12;
                                        _selectedYear--;
                                      } else {
                                        _selectedMonth--;
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  DateFormat('MMMM yyyy').format(
                                    DateTime(_selectedYear, _selectedMonth),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.chevron_right),
                                  onPressed: () {
                                    setState(() {
                                      if (_selectedMonth == 12) {
                                        _selectedMonth = 1;
                                        _selectedYear++;
                                      } else {
                                        _selectedMonth++;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),

                            // Calendar Grid
                            _buildCalendarGrid(),
                            // Status Message
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                'Tell us how you are doing today for us to make more precise predictions on your next period!',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Cycle Prediction Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Your menstrual cycle',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Next period in 10 days',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink[400],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Your cycle has been regular. Keep tracking for more accurate predictions!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
              _buildNavItem(Icons.home_filled, 'Home', Colors.grey!, 0),
              _buildNavItem(Icons.calendar_month_outlined, 'Tracker', Colors.green[800]!, 1),
              const SizedBox(width: 40),
              _buildNavItem(Icons.medical_services_outlined, 'Telemedicine', Colors.grey, 2),
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

  Widget _buildCalendarGrid() {
    final daysInMonth = DateTime(_selectedYear, _selectedMonth + 1, 0).day;
    final firstDayOfMonth = DateTime(_selectedYear, _selectedMonth, 1);
    final firstWeekdayOfMonth = firstDayOfMonth.weekday;

    return Column(
      children: [
        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text('MON'),
            Text('TUE'),
            Text('WED'),
            Text('THU'),
            Text('FRI'),
            Text('SAT'),
            Text('SUN'),
          ],
        ),
        const SizedBox(height: 0),
        // Calendar days
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          padding: EdgeInsets.zero,
          itemCount: 42, // 6 weeks * 7 days
          itemBuilder: (context, index) {
            final dayOffset = index - (firstWeekdayOfMonth - 1);
            if (dayOffset < 0 || dayOffset >= daysInMonth) {
              return Container();
            }

            final dayNumber = dayOffset + 1;
            final isToday = dayNumber == _currentDate.day &&
                _selectedMonth == _currentDate.month &&
                _selectedYear == _currentDate.year;
            final isPeriodDay = _periodDays.contains(dayNumber);
            final hasSymptoms = _symptomsLoggedDays.contains(dayNumber);

            return MouseRegion(
              cursor: SystemMouseCursors.click,  // Changes cursor to pointing hand
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SymptomsScreen(
                        selectedDate: DateTime(_selectedYear, _selectedMonth, dayNumber),
                      ),
                    ),
                  ).then((healthData) {
                    if (healthData != null) {
                      setState(() {
                        if (healthData['hasPeriod'] == true) {
                          _periodDays.add(dayNumber);
                        }
                        if (healthData['symptoms'].isNotEmpty) {
                          _symptomsLoggedDays.add(dayNumber);
                        }
                      });
                    }
                  });
                },
                child: StatefulBuilder(
                  builder: (context, setState) {
                    // ignore: unused_local_variable
                    bool isHovered = false;

                    return MouseRegion(
                      onEnter: (_) => setState(() => isHovered = true),
                      onExit: (_) => setState(() => isHovered = false),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Period day background
                          if (isPeriodDay)
                            Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          // Today indicator
                          if (isToday)
                            Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                shape: BoxShape.circle,
                              ),
                            ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dayNumber.toString(),
                                style: TextStyle(
                                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              if (hasSymptoms)
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
