import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/home_controller/home_controller.dart';

class TodaysAttendence extends StatefulWidget {
  const TodaysAttendence({super.key});

  @override
  State<TodaysAttendence> createState() => _TodaysAttendenceState();
}

class _TodaysAttendenceState extends State<TodaysAttendence> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 100,
                width: 160,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Icon(
                            Icons.login_outlined,
                            color: Colors.blue,
                          )),
                        ),
                        Text("  Check in")
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "12:00",
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
                    Text("On")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 100,
                width: 160,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Icon(
                            Icons.logout_outlined,
                            color: Colors.blue,
                          )),
                        ),
                        Text("Check out")
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "07:10",
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
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 100,
                width: 160,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Icon(
                            Icons.coffee_rounded,
                            color: Colors.blue,
                          )),
                        ),
                        Text(" Break time")
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "00:30",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "min",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        )
                      ],
                    ),
                    Text("Avg time 30 mins")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 100,
                width: 160,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Icon(
                            Icons.list_alt,
                            color: Colors.blue,
                          )),
                        ),
                        Text(" Total days")
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "21",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ],
                    ),
                    Text("Working days")
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
