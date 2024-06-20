import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  HomeController() {
    addcheckinListener();
  }
  DateTime? lastCheckOut;
  DateTime? checkinDate;
  Duration totalBreakTime = Duration.zero;

  addcheckinListener() {
    FirebaseFirestore.instance.collection('dates').snapshots().listen((event) {
      getFirstCheckInOfDay();
      getLastCheckInOfDay();
    });
  }

  addData(bool isSlide) {
    log("data adding");

    DateTime now = DateTime.now();
    String formattedDateTime =
        "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}";
    FirebaseFirestore.instance.collection('dates').add({
      'dateTime': now.millisecondsSinceEpoch,
      "check": isSlide,
    }).then((value) {
      log("Date and time added to Firestore!");
    }).catchError((error) {
      log("Failed to add date and time: $error");
    });
    log("data added");
  }

  // void fetchData() {
  //   log("Fetching data");
  //   FirebaseFirestore.instance.collection('dates').get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       DateTime dateTime = doc['dateTime'].toDate();
  //       String date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
  //       String time = "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  //       log("Date: $date, Time: $time");
  //     });
  //   }).catchError((error) {
  //     log("Failed to fetch data: $error");
  //   });
  //}

  Future<void> getFirstCheckInOfDay() async {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('dates')
        .where('check', isEqualTo: true)
        .where('dateTime',
            isGreaterThanOrEqualTo: startOfDay.millisecondsSinceEpoch)
        .where('dateTime', isLessThanOrEqualTo: endOfDay.millisecondsSinceEpoch)
        .orderBy('dateTime', descending: false)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var firstCheckIn =
          querySnapshot.docs.first.data() as Map<String, dynamic>;
      bool checkin = firstCheckIn['check'];
      log("check--$checkin");
      checkinDate =
          DateTime.fromMillisecondsSinceEpoch(firstCheckIn['dateTime']);
      log("$checkinDate");
      log("First check-in: $checkin at $checkinDate");
      notifyListeners();
    } else {
      log("No check-in");
    }
  }

  Future<void> getLastCheckInOfDay() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('dates')
        .where('check', isEqualTo: false)
        .orderBy('dateTime', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      lastCheckOut = DateTime.fromMillisecondsSinceEpoch(
          querySnapshot.docs.first.data()["dateTime"]);

      notifyListeners();
    } else {
      log("No check-in");
    }
  }

  Future<void> break_time() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('dates')
        .orderBy('dateTime', descending: false)
        .get();

    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    checkinDate = null;
    lastCheckOut = null;
    totalBreakTime = Duration.zero;

    DateTime? lastCheckOutTime;

    for (var doc in docs) {
      var data = doc.data() as Map<String, dynamic>;
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(data['dateTime']);
      bool isCheckIn = data['check'];

      if (isCheckIn) {
        checkinDate ??= dateTime;
        if (lastCheckOutTime != null) {
          totalBreakTime += dateTime.difference(lastCheckOutTime);
        }
      } else {
        lastCheckOut = dateTime;
        lastCheckOutTime = dateTime;
      }
    }

    log("Total break time: $totalBreakTime");
    notifyListeners();
  }
}
