import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/holiday_list/holiday_list.dart';
import 'package:flutter_application_1/view/profile/profile.dart';
import 'package:flutter_application_1/view/homepage/home_page.dart';
import 'package:flutter_application_1/view/leave_page/leave_page.dart';
import 'package:flutter_application_1/view/team_list/team_list.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<Widget> listscreen = [
    Homepage(),
    Leave_page(),
    TeamList(),
    HolidayList(),
    ProfileScreen()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listscreen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.grey,
        useLegacyColorScheme: true,

        currentIndex: selectedIndex, // Set the current index
        onTap: (value) {
          setState(() {
            selectedIndex = value; // Update the selected index
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home', // Add label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_outlined),
            label: 'Team leave', // Add label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_outlined),
            label: 'Holiday list', // Add label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.holiday_village_outlined),
            label: 'Team list', // Add label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile', // Add label
          ),
        ],
      ),
    );
  }
}
