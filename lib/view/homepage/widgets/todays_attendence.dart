import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/home_controller/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
              padding: const EdgeInsets.symmetric(vertical: 5),
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
                        Consumer<HomeController>(
                          builder: (context, value, child) {
                            String date;
                            date = "";
                            var d = value.checkinDate;
                            log(" checkindate--$d");
                            if (value.checkinDate != null) {
                              date = DateFormat("h:m a")
                                  .format(value.checkinDate!);
                            }
                            log("check in--$date");
                            return Text(
                              value.checkinDate != null ? date : "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            );
                          },
                        ),
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
                          width: 40,
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
                        Consumer<HomeController>(
                          builder: (context, value, child) {
                            String date;
                            date = "";
                            if (value.lastCheckOut != null) {
                              date = DateFormat("h:m a")
                                  .format(value.lastCheckOut!);
                            }
                            log("check out--$date");
                            return Text(
                              date,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            );
                          },
                        ),
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
              padding: const EdgeInsets.symmetric(vertical: 5),
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
                        Consumer<HomeController>(
                          builder: (context, value, child) {
                            String formattedTime = '';

                            if (value.totalBreakTime != null &&
                                value.totalBreakTime != Duration.zero) {
                              formattedTime = DateFormat("mm:ss").format(
                                  DateTime(0).add(value.totalBreakTime));
                            }

                            return Text(
                              formattedTime,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            );
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "sec",
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
                        Consumer<HomeController>(
                          builder: (context, value, child) {
                            int totaldays =
                                value.getTotalWorkingDaysOfCurrentMonth();

                            return Text(
                              "$totaldays",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            );
                          },
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
