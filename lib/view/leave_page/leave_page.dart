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
            Icon(Icons.tune_outlined),
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
                              "20",
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
                              "20",
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
                            Text(
                              "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.green),
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
                              "20",
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
}
