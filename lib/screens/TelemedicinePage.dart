import 'package:flutter/material.dart';
import 'package:flutter_application_1/ai_chat/ChatPage.dart';
import 'package:flutter_application_1/screens/TrackerPage.dart';
import 'package:flutter_application_1/screens/HomePage.dart';

class TelemedicinePage extends StatefulWidget {
  @override
  _TelemedicinePageState createState() => _TelemedicinePageState();
}

class _TelemedicinePageState extends State<TelemedicinePage> {
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrackerPage()),
        );
        break;
      case 2: // Medical
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => TelemedicinePage()),
        // );
        // break;
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
      appBar: AppBar(
        title: const Text('Telemedicine',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for doctors...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) => _buildDoctorCard(context, index),
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
              _buildNavItem(Icons.home_filled, 'Home', Colors.grey!, 0),
              _buildNavItem(Icons.calendar_month_outlined, 'Tracker', Colors.grey, 1),
              const SizedBox(width: 40),
              _buildNavItem(Icons.medical_services_outlined, 'Telemedicine', Colors.green[800]!, 2),
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

  Widget _buildDoctorCard(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          radius: 25,
        ),
        title: Text('Dr. John Doe $index'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Specialist in Gynecology'),
            SizedBox(height: 4),
            Text(
              'Price: \$50 per consultation',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorDetailsPage(
                  doctorName: 'Dr. John Doe $index',
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[800],
            foregroundColor: Colors.white,
          ),
          child: const Text('Book'),
        ),
      ),
    );
  }
}

class DoctorDetailsPage extends StatelessWidget {
  final String doctorName;

  const DoctorDetailsPage({Key? key, required this.doctorName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctorName),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctorName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Specialist in Gynecology',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Available Slots:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => _buildTimeSlot(context, index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlot(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text('Date: 2025-01-2${index + 1}'),
        subtitle: const Text('Time: 10:00 AM - 11:00 AM'),
        trailing: ElevatedButton(
          onPressed: () => _showBookingConfirmation(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[800],
            foregroundColor: Colors.white,
          ),
          child: const Text('Book'),
        ),
      ),
    );
  }

  void _showBookingConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Booking'),
        content: Text('Book appointment with $doctorName for \$50?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[800],
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}