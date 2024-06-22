import 'dart:developer';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  HomeController() {
    initialize();
  }

  DateTime? lastCheckOut;
  DateTime dateSelected = DateTime.now();
  DateTime? checkinDate;
  Duration totalBreakTime = Duration.zero;
  DateTime get selectedDate => dateSelected;
  StreamSubscription<QuerySnapshot>? subscription;

  void initialize() {
    fetchDataForSelectedDate();
    addCheckinListener();
  }

  void addCheckinListener() {
    subscription?.cancel();
    subscription = FirebaseFirestore.instance
        .collection('dates')
        .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("dateTime",
            isGreaterThanOrEqualTo: dateSelected.millisecondsSinceEpoch)
        .where("dateTime",
            isLessThan:
                dateSelected.add(Duration(days: 1)).millisecondsSinceEpoch)
        .snapshots()
        .listen((event) {
      log("data updated ");
      fetchDataForSelectedDate();
    });
  }

  Future<void> fetchDataForSelectedDate() async {
    await getFirstCheckInOfDay();
    await getLastCheckInOfDay();
    await calculateBreakTime();
    getTotalWorkingDaysOfCurrentMonth();
    notifyListeners();
  }

  Future<void> assignDate(int year, int month, int day) async {
    dateSelected = DateTime(year, month, day);
    await fetchDataForSelectedDate();
    addCheckinListener();
  }

  Future<void> addData(bool isSlide) async {
    log("data adding");
    DateTime now = DateTime.now();
    FirebaseFirestore.instance.collection('dates').add({
      'dateTime': now.millisecondsSinceEpoch,
      "check": isSlide,
      "userid": FirebaseAuth.instance.currentUser!.uid
    }).then((value) {
      log("Date and time added to Firestore!");
    }).catchError((error) {
      log("Failed to add date and time: $error");
    });
    log("data added");
  }

  Future<void> getFirstCheckInOfDay() async {
    DateTime startOfDay =
        DateTime(dateSelected.year, dateSelected.month, dateSelected.day);
    DateTime endOfDay = DateTime(dateSelected.year, dateSelected.month,
        dateSelected.day, 23, 59, 59, 999);

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('dates')
        .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
      checkinDate =
          DateTime.fromMillisecondsSinceEpoch(firstCheckIn['dateTime']);
      log("First check-in at $checkinDate");
    } else {
      log("No check-in found");
      checkinDate = null;
    }
  }

  Future<void> getLastCheckInOfDay() async {
    DateTime startOfDay =
        DateTime(dateSelected.year, dateSelected.month, dateSelected.day);
    DateTime endOfDay = DateTime(dateSelected.year, dateSelected.month,
        dateSelected.day, 23, 59, 59, 999);

    var querySnapshot = await FirebaseFirestore.instance
        .collection('dates')
        .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('check', isEqualTo: false)
        .where('dateTime',
            isGreaterThanOrEqualTo: startOfDay.millisecondsSinceEpoch)
        .where('dateTime', isLessThanOrEqualTo: endOfDay.millisecondsSinceEpoch)
        .orderBy('dateTime', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      lastCheckOut = DateTime.fromMillisecondsSinceEpoch(
          querySnapshot.docs.first.data()["dateTime"]);
    } else {
      log("No check-out found");
      lastCheckOut = null;
    }
  }

  Future<void> calculateBreakTime() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('dates')
          .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('dateTime', descending: false)
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      checkinDate = null;
      lastCheckOut = null;
      totalBreakTime = Duration.zero;

      DateTime? lastCheckOutTime;
      bool isAfter7pm = false;
      log(docs.length.toString());
      for (var doc in docs) {
        var data = doc.data() as Map<String, dynamic>;
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch(data['dateTime']);
        bool isCheckIn = data['check'];

        if (isCheckIn) {
          checkinDate ??= dateTime;
          log("first if ");
          if (lastCheckOutTime != null && !isAfter7pm) {
            totalBreakTime += dateTime.difference(lastCheckOutTime);
            log("second if ");
          }
        } else {
          log("first else ");
          lastCheckOut = dateTime;
          lastCheckOutTime = dateTime;
        }

        if (dateTime.hour >= 19) {
          isAfter7pm = true;
          log("thrid if ");
        } else if (dateTime.hour >= 9) {
          isAfter7pm = false;
          log("fourth if ");
        }
      }

      log("Total break time: $totalBreakTime");
    } catch (e) {
      log("Error in calculateBreakTime: $e");
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
