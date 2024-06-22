import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/leave_model/leave_model.dart';

class leave_controller with ChangeNotifier {
  int datedifference = 0;

  int get dateDifference => datedifference;
  List<LeaveModel> filteredLeaveList = [];
  leave_controller() {
    fetchData();
  }
  var collectionReference = FirebaseFirestore.instance.collection("leave");
  List<LeaveModel> LeaveList = [];

  Future addData(LeaveModel leaveModel) async {
    final data = {
      "Title": leaveModel.title,
      "contact_no": leaveModel.contact_no,
      "leave_type": leaveModel.leave_type,
      "start_date": leaveModel.start_date,
      "end_date": leaveModel.end_date,
      "reason": leaveModel.reason,
      "userid": FirebaseAuth.instance.currentUser!.uid
    };

    await collectionReference.add(data);
  }

  fetchData() {
    collectionReference
        .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      //  log(event.docs.length);
      LeaveList = event.docs
          .map((e) => LeaveModel(
                title: e["Title"],
                contact_no: e["contact_no"],
                leave_type: e["leave_type"],
                start_date: e["start_date"],
                end_date: e["end_date"],
                reason: e["reason"],
              ))
          .toList();
      notifyListeners();
    });
  }

  int? calculateDateDifference(LeaveModel leaveModel) {
    if (leaveModel.start_date == null || leaveModel.end_date == null) {
      log("Start date or end date is null");
      return null;
    }

    try {
      DateTime start = parseDate(leaveModel.start_date!);
      DateTime end = parseDate(leaveModel.end_date!);

      if (end.isBefore(start)) {
        log("End date is before start date");
        return null;
      }

      Duration difference = end.difference(start);
      int datedifference = difference.inDays;

      log("Difference in days: $datedifference");

      this.datedifference = datedifference;
      return datedifference;
    } catch (e) {
      log("Error parsing dates: $e");
      return null;
    }
  }

  DateTime parseDate(String dateString) {
    List<String> parts = dateString.split('-');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  filterLeaves() {
    filteredLeaveList = LeaveList.where((leave) {
      return (calculateDateDifference(leave) ?? 0) > 2;
    }).toList();
    notifyListeners();
  }
}
