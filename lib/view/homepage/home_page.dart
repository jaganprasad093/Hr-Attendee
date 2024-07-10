import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/home_controller/home_controller.dart';
import 'package:flutter_application_1/controller/registration_controller/registration_controller.dart';
import 'package:flutter_application_1/view/homepage/widgets/today_activity.dart';
import 'package:flutter_application_1/view/homepage/widgets/slide_button.dart';
import 'package:flutter_application_1/view/homepage/widgets/todays_attendence.dart';
import 'package:flutter_application_1/view/homepage/widgets/view_all.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isselected = false;
  List<Map<String, String>> dateList = [];
  String? userName;
  bool isSlide = false;
  GlobalKey todays_widgetskey = GlobalKey();
  ScrollController date_list_scrollcontroller = ScrollController();
  scrolltochild() {
    final context = todays_widgetskey.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      final offset = box.localToGlobal(Offset.zero,
          ancestor: context.findRenderObject()?.parent as RenderObject);
      date_list_scrollcontroller.animateTo(offset.dx,
          duration: Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  @override
  void initState() {
    super.initState();
    dateList = getDateList(30);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => scrolltochild(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: Consumer<registration_controller>(
                  builder: (context, value, child) => CircleAvatar(
                    backgroundImage:
                        NetworkImage(value.users_list.first.image ?? ""),
                  ),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<registration_controller>(
                      builder: (context, value, child) => Text(
                        context
                                .read<registration_controller>()
                                .user
                                ?.firstname ??
                            "Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    Text(
                      "Flutter developer",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  controller: date_list_scrollcontroller,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  scrollDirection: Axis.horizontal,
                  child: Consumer<HomeController>(
                    builder: (context, value, child) => Row(
                      children: List.generate(dateList.length, (index) {
                        return Row(
                          children: [
                            InkWell(
                              child: Container(
                                key: DateTime.now().day ==
                                        int.parse(dateList[index]['day']!)
                                    ? todays_widgetskey
                                    : null,
                                decoration: BoxDecoration(
                                    color: DateTime.now().day ==
                                            int.parse(dateList[index]['day']!)
                                        ? Colors.blue
                                        : Colors.grey.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 5)),
                                    Text(
                                      dateList[index]['day']!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: DateTime.now().day ==
                                                  int.parse(
                                                      dateList[index]['day']!)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Text(
                                      dateList[index]['date']!,
                                      style: TextStyle(
                                          color: DateTime.now().day ==
                                                  int.parse(
                                                      dateList[index]['day']!)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 5)),
                                  ],
                                ),
                              ),
                              onTap: () {
                                value.assignDate(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    int.parse(dateList[index]['day']!));
                              },
                            ),
                            if (index < dateList.length - 1)
                              SizedBox(
                                width: 20,
                              ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today attendance",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: TodaysAttendence(),
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
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => View_all(),
                                ));
                          },
                          child: Text(
                            "View all",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('dates')
                      .orderBy("dateTime", descending: true)
                      .limit(4)
                      .where("userid",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    var date = snapshot.data;
                    return SliverList.separated(
                      itemBuilder: (context, index) => Check_in(
                        checkin: date?.docs[index].data()["check"],
                        date: DateTime.fromMillisecondsSinceEpoch(
                          date?.docs[index].data()["dateTime"],
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                      itemCount: date?.docs.length ?? 0,
                    );
                  })
            ],
          ),
        ),
        floatingActionButton: SlideButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  List<Map<String, String>> getDateList(int days) {
    List<Map<String, String>> dateList = [];
    DateTime now = DateTime(DateTime.now().year, DateTime.now().month);

    DateFormat dayFormatter = DateFormat('dd');
    DateFormat dateFormatter = DateFormat('E');

    for (int i = 0; i < days; i++) {
      DateTime date = now.add(Duration(days: i));
      String day = dayFormatter.format(date);
      String formattedDate = dateFormatter.format(date);
      dateList.add({'day': day, 'date': formattedDate});
    }
    return dateList;
  }
}
