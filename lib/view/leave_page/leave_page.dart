import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/leave_controller/leave_controller.dart';
import 'package:flutter_application_1/view/leave_page/apply_leave/apply_leave.dart';
import 'package:flutter_application_1/view/leave_page/widgets/custom_leave_widgets.dart';
import 'package:flutter_application_1/view/leave_page/widgets/team_leave_widgets.dart';
import 'package:provider/provider.dart';

class Leave_page extends StatefulWidget {
  const Leave_page({super.key});

  @override
  State<Leave_page> createState() => _Leave_pageState();
}

class _Leave_pageState extends State<Leave_page> {
  bool isCheckedApproved = false;
  bool isCheckedUnapproved = false;
  bool isCheckedPending = false;
  bool isCheckedSickLeave = false;
  bool isCheckedPlannedLeave = false;
  bool isCheckedHoliday = false;

  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "All leaves",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApplyLeave(),
                    ));
              },
              child: Icon(
                Icons.add_box_outlined,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
                onTap: () {
                  showFilter();
                },
                child: Icon(Icons.tune_outlined)),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 150,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                  child: Stack(children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 145,
                        width: 175,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Leave\nBalanace",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  height: 150,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(15)),
                  child: Stack(children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 145,
                        width: 175,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Leave\nApproved",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.yellow),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 150,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15)),
                  child: Stack(children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 145,
                        width: 175,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Leave\nPending",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Consumer<leave_controller>(
                              builder: (context, value, child) => Text(
                                value.LeaveList.length == null
                                    ? "0"
                                    : "${value.LeaveList.length}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.green),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  height: 150,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15)),
                  child: Stack(children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 145,
                        width: 175,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Leave\nCancelled",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            ),
            TabBar(
                onTap: (value) {
                  setState(() {
                    currentTabIndex = value;
                  });
                },
                tabs: [
                  Tab(
                    text: "Upcoming",
                  ),
                  Tab(
                    text: "Past",
                  ),
                  Tab(
                    text: "Team Leave",
                  ),
                ]),
            Expanded(
              child: TabBarView(children: [
                Consumer<leave_controller>(
                  builder: (context, value, child) => ListView.separated(
                      itemBuilder: (context, index) {
                        log(value.LeaveList.length.toString());
                        return Custom_leave_widgets(
                          leaveModel: value.LeaveList[index],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: value.LeaveList.length),
                ),
                Consumer<leave_controller>(
                  builder: (context, value, child) => ListView.separated(
                      itemBuilder: (context, index) => Custom_leave_widgets(
                            leaveModel: value.LeaveList[index],
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: value.LeaveList.length),
                ),
                ListView.separated(
                    itemBuilder: (context, index) => TeamLeave_widgets(),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: 3),
              ]),
            )
          ],
        ),
      ),
    );
  }

// filter bottomsheet
  void showFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 550,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filter",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Status",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.blue,
                      value: isCheckedApproved,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedApproved = value!;
                        });
                      },
                    ),
                    Text(
                      "Approved",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.blue,
                      value: isCheckedUnapproved,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedUnapproved = value!;
                        });
                      },
                    ),
                    Text(
                      "Unapproved",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.blue,
                      value: isCheckedPending,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedPending = value!;
                        });
                      },
                    ),
                    Text(
                      "Pending",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Text(
                  "Leave Type",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.blue,
                      value: isCheckedSickLeave,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedSickLeave = value!;
                        });
                      },
                    ),
                    Text(
                      "Sick leave",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.blue,
                      value: isCheckedPlannedLeave,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedPlannedLeave = value!;
                        });
                      },
                    ),
                    Text(
                      "Planned leave",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.blue,
                      value: isCheckedHoliday,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedHoliday = value!;
                        });
                      },
                    ),
                    Text(
                      "Holiday",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 150,
                      child: Center(
                        child: Text(
                          "Reset",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      child: Center(
                        child: Text(
                          "Apply",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
