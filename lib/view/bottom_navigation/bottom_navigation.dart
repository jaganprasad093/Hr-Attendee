import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/holiday_list/holiday_list.dart';
import 'package:flutter_application_1/view/homepage/home_page.dart';
import 'package:flutter_application_1/view/profile/profile.dart'; // Ensure this import is correct
import 'package:flutter_application_1/view/leave_page/leave_page.dart';
import 'package:flutter_application_1/view/team_list/team_list.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<Widget> listscreen = [
    Homepage(),
    Leave_page(),
    TeamList(),
    HolidayList(),
    ProfileScreen(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listscreen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // Consider using `fixed` for stability
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white, // Changed to white for better contrast
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_outlined),
            label: 'Leave',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Team',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.holiday_village_outlined),
            label: 'Holiday',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
