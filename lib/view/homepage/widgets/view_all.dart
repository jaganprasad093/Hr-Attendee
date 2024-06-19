import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/homepage/widgets/today_activity.dart';

class View_all extends StatefulWidget {
  const View_all({super.key});

  @override
  State<View_all> createState() => _View_allState();
}

class _View_allState extends State<View_all> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          title: Text(
            "Today activity",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('dates').snapshots(),
              builder: (context, snapshot) {
                var date = snapshot.data;
                return ListView.separated(
                    itemBuilder: (context, index) => Check_in(
                        date: DateTime.fromMillisecondsSinceEpoch(
                            date?.docs[index].data()["dateTime"]),
                        checkin: date?.docs[index].data()["check"]),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ),
                    itemCount: date?.docs.length ?? 0);
              }),
        ));
  }
}
