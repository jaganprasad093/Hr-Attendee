import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/homepage/home_page.dart';

class Bottom_navigation extends StatefulWidget {
  const Bottom_navigation({super.key});

  @override
  State<Bottom_navigation> createState() => _Bottom_navigationState();
}

class _Bottom_navigationState extends State<Bottom_navigation> {
  List listscreen = [
    Homepage(),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.brown,
    ),
    Container(
      color: Colors.cyan,
    ),
  ];
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listscreen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          // backgroundColor: Colors.black12,
          // currentIndex: selectedIndex,
          // fixedColor: Colors.black,
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.camera,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
            ),
          ]),
    );
  }
}
