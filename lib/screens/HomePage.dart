import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateTime _currentDate = DateTime.now();
  final List<int> _periodDays = [19, 20, 21, 22, 23, 24]; // Example period days
  final List<int> _symptomsLoggedDays = [5, 6, 7, 8]; // Days with logged symptoms
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

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
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green[100]!,
                      Colors.green[50]!,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'VH',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.notifications_none),
                          onPressed: () {
                            // Placeholder for notification button
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Hi Y!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
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
                            const SizedBox(height: 20),

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
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 7.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
      mainAxisSize: MainAxisSize.min,
      children: [
                IconButton(
      icon: const Icon(Icons.home_filled),
      iconSize: 28, // Reduced from 32
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      color: Colors.green[800],
      onPressed: () {
        // Placeholder for Home button
      },
    ),
    const SizedBox(height: 2), // Small spacing between icon and text
    Container(
      width: 42,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Text(
        'Home',
        style: TextStyle(
          color: Colors.green[800],
          fontSize: 6,
          height: 1.0,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ],
),
            IconButton(
              icon: const Icon(Icons.calendar_month_outlined),
              iconSize: 32,
              color: Colors.grey,
              onPressed: () {
                // Placeholder for Period Tracker button
              },
            ),
            const SizedBox(width: 40), // Space for the notch
            IconButton(
              icon: const Icon(Icons.medical_services_outlined),
              iconSize: 32,
              color: Colors.grey,
              onPressed: () {
                // Placeholder for Telemedicine button
              },
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              iconSize: 32,
              color: Colors.grey,
              onPressed: () {
                // Placeholder for Profile button
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[100],
        child: const Icon(Icons.chat_outlined, color: Colors.blue),
        onPressed: () {
          // Placeholder for Floating AI button
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
          ),
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

            return GestureDetector(
              onTap: () {
                // Placeholder for date selection
              },
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
          },
        ),
      ],
    );
  }
}
