import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  HomeController() {
    addcheckinListener();
  }
  DateTime? lastCheckOut;
  DateTime DateSelected = DateTime.now();
  DateTime? checkinDate;
  Duration totalBreakTime = Duration.zero;

  addcheckinListener() {
    FirebaseFirestore.instance
        .collection('dates')
        .where("dateTime",
            isGreaterThanOrEqualTo: DateSelected.millisecondsSinceEpoch)
        .where("dateTime",
            isLessThan: DateSelected.copyWith(day: DateSelected.day + 1))
        .snapshots()
        .listen((event) {
      getFirstCheckInOfDay();
      getLastCheckInOfDay();
      break_time();
      getTotalWorkingDaysOfCurrentMonth();
    });
  }

  Future<void> assignDate(int year, int month, int day) async {
    DateSelected = DateTime(year, month, day);
    getFirstCheckInOfDay();
    getLastCheckInOfDay();
    break_time();
    getTotalWorkingDaysOfCurrentMonth();
    notifyListeners();
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
        .where("dateTime",
            isGreaterThanOrEqualTo: DateSelected.millisecondsSinceEpoch)
        .where("dateTime",
            isLessThan: DateSelected.copyWith(day: DateSelected.day + 1))
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
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('dates')
          .orderBy('dateTime', descending: false)
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      checkinDate = null;
      lastCheckOut = null;
      totalBreakTime = Duration.zero;

      DateTime? lastCheckOutTime;
      bool isAfter7pm = false;

      for (var doc in docs) {
        var data = doc.data() as Map<String, dynamic>;
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch(data['dateTime']);
        bool isCheckIn = data['check'];

        if (isCheckIn) {
          checkinDate ??= dateTime;
          if (lastCheckOutTime != null && !isAfter7pm) {
            totalBreakTime += dateTime.difference(lastCheckOutTime);
          }
        } else {
          lastCheckOut = dateTime;
          lastCheckOutTime = dateTime;
        }

        if (dateTime.hour >= 19) {
          isAfter7pm = true;
        } else if (dateTime.hour >= 9) {
          isAfter7pm = false;
        }
      }

      log("Total break time: $totalBreakTime");
      notifyListeners();
    } catch (e) {
      log("Error in break_time: $e");
    }
  }

  int getTotalWorkingDaysOfCurrentMonth() {
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;

    int totalDays = DateTime(year, month + 1, 0).day;
    int workingDays = 0;

    for (int day = 1; day <= totalDays; day++) {
      DateTime date = DateTime(year, month, day);
      if (date.weekday != DateTime.saturday &&
          date.weekday != DateTime.sunday) {
        workingDays++;
      }
    }

    return workingDays;
  }
}
