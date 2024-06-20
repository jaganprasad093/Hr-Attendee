import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    dateList = getDateList(30);
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
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/12169270/pexels-photo-12169270.jpeg?auto=compress&cs=tinysrgb&w=600"),
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
                  padding: EdgeInsets.symmetric(vertical: 20),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(dateList.length, (index) {
                      return Row(
                        children: [
                          InkWell(
                            child: Container(
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
                                    dateList[index]['day']!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                  Text(dateList[index]['date']!),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 5)),
                                ],
                              ),
                            ),
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
    DateTime now = DateTime.now();
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
