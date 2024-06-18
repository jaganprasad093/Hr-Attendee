import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/homepage/widgets/check_in_out.dart';
import 'package:intl/intl.dart';
import 'package:slider_button/slider_button.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, String>> dateList = [];
  String? userName;

  @override
  void initState() {
    super.initState();
    dateList = getDateList(10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text(
                    userName ?? "Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                                dateList[index]['day']!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                              Text(dateList[index]['date']!),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5)),
                            ],
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            SliverGrid.builder(
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
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
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.blue,
                          ),
                          Text("Check in")
                        ],
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
                ],
              ),
            ),
            SliverList.separated(
              itemBuilder: (context, index) => Check_in(),
              separatorBuilder: (context, index) => SizedBox(
                height: 20,
              ),
              itemCount: 5,
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
