import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var arr = List.filled(7, "");

  @override
  Widget build(BuildContext context) {
    arr[0] = "Mon";
    arr[1] = "Tue";
    arr[2] = "Wed";
    arr[3] = "Thu";
    arr[4] = "Fri";
    arr[5] = "Sat";
    arr[6] = "Sun";
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: CircleAvatar(
              child: Icon(Icons.person_2_outlined),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("sub title")
              ],
            ),
            actions: [
              CircleAvatar(
                child: Icon(Icons.notification_important_outlined),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(7, (index) {
                  return Row(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("date"),
                            Text("2"),
                          ],
                        ),
                      ),
                      if (index < 6) // Add separator except after the last item
                        SizedBox(
                          width: 20, // Adjusting width for horizontal separator
                        ),
                    ],
                  );
                }),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("Today attendence")],
            ),
          ),
          SliverGrid.builder(
            itemCount: 4,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [Icon(Icons.exit_to_app), Text("Check in")],
                    ),
                    Row(
                      children: [
                        Text(
                          "10:10",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Am",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        )
                      ],
                    ),
                    Text("Go home")
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
