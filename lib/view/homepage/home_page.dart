import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/view/homepage/widgets/check_in_out.dart';
import 'package:slider_button/slider_button.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: CustomScrollView(
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
                    "asdfg",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text(
                    "sub title",
                    style: TextStyle(fontSize: 20),
                  )
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
                padding: EdgeInsets.symmetric(vertical: 20),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(7, (index) {
                    return Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5)),
                              Text(
                                "07",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                              Text("sat"),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5)),
                            ],
                          ),
                        ),
                        if (index <
                            6) // Add separator except after the last item
                          SizedBox(
                            width:
                                20, // Adjusting width for horizontal separator
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
                children: [
                  Text(
                    "Today attendence",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            SliverGrid.builder(
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                mainAxisSpacing: 10.0, // Vertical space between grid items
                crossAxisSpacing: 10.0, // Horizontal space between grid items
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
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
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today Activity",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        "View all",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // ListView.separated(
                  //     itemBuilder: ,
                  //     separatorBuilder:,
                  //     itemCount: 3)
                ],
              ),
            ),
            SliverList.separated(
              itemBuilder: (context, index) => Check_in(),
              separatorBuilder: (context, index) => SizedBox(
                height: 20,
              ),
              itemCount: 3,
            )
          ],
        ),
      ),
      floatingActionButton: SliderButton(
        backgroundColor: Colors.red,
        height: 60,
        shimmer: false,
        action: () async {
          return false;
        },
        label: Text(
          "Swipe to check out",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
        ),
        icon: Center(
            child: Icon(
          Icons.arrow_forward,
          color: Colors.redAccent,
          size: 30.0,
          semanticLabel: 'Text to announce in accessibility modes',
        )),
        boxShadow: BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 4,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
