import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/leave_model/leave_model.dart';
import 'package:intl/intl.dart';

class leave_controller with ChangeNotifier {
  int datedifference = 0;

  int get dateDifference => datedifference;
  List<LeaveModel> filteredLeaveList = [];

  int totalLeave = 0;
  late int leaveapproved;

  leave_controller() {
    fetchData();
    TeamLeave();
  }
  var collectionReference = FirebaseFirestore.instance.collection("leave");
  List<LeaveModel> leave_list = [];
  List<LeaveModel> teamLeaveList = [];
  List<LeaveModel> past_list = [];
  List<LeaveModel> upcomming_list = [];
  List<LeaveModel> approvel_list = [];

  var reject;

  Future addData(LeaveModel leaveModel) async {
    final data = {
      "Title": leaveModel.title,
      "contact_no": leaveModel.contact_no,
      "leave_type": leaveModel.leave_type,
      "start_date": leaveModel.start_date,
      "end_date": leaveModel.end_date,
      "reason": leaveModel.reason,
      "userid": FirebaseAuth.instance.currentUser!.uid,
      "current_date": DateTime.now().millisecondsSinceEpoch
    };

    await collectionReference.add(data);
  }

  fetchData() {
    collectionReference
        .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        // .where("current_date",
        //     isGreaterThanOrEqualTo: DateTime.now().millisecondsSinceEpoch)
        .orderBy("current_date", descending: true)
        .snapshots()
        .listen((event) {
      //  log(event.docs.length);
      leave_list = event.docs
          .map((e) => LeaveModel(
              title: e["Title"],
              contact_no: e["contact_no"],
              leave_type: e["leave_type"],
              start_date: e["start_date"],
              end_date: e["end_date"],
              reason: e["reason"],
              current_date: e["current_date"]))
          .toList();
      // past list
      past_list = leave_list.where((past) {
        log("pastlist--${past.start_date},${DateTime.now().millisecondsSinceEpoch}");
        var _startdate = DateFormat('dd-MM-yyyy')
            .parse(past.start_date!)
            .millisecondsSinceEpoch;
        return (_startdate) < DateTime.now().millisecondsSinceEpoch;
      }).toList();
      // upcoming list
      upcomming_list = leave_list.where((x) {
        var _current_date = DateFormat('dd-MM-yyyy')
            .parse(x.start_date!)
            .millisecondsSinceEpoch;
        return (_current_date) > DateTime.now().millisecondsSinceEpoch;
      }).toList();
      // upcomming_list.sort(
      //     (a, b) => a.current_date!.compareTo(int.parse(b.start_date ?? "")));
      notifyListeners();
    });
    log("pastlist--$past_list");
    log("upcoming leaves--${upcomming_list}");
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
      int datedifference = difference.inDays + 1;

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
    filteredLeaveList = leave_list.where((leave) {
      return (calculateDateDifference(leave) ?? 0) > 2 ||
          leave.leave_type == "Sick leave" ||
          leave.leave_type == "Planned leave";
    }).toList();
    log("leavelist--$filteredLeaveList");
    notifyListeners();
  }

  void resetData() {
    leave_list.clear();
    filteredLeaveList.clear();
    notifyListeners();
  }

  TeamLeave() {
    collectionReference
        .where("userid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      teamLeaveList = event.docs
          .map((e) => LeaveModel(
                title: e["Title"],
                contact_no: e["contact_no"],
                leave_type: e["leave_type"],
                start_date: e["start_date"],
                end_date: e["end_date"],
                reason: e["reason"],
              ))
          .toList();

      // teamLeaveList=teamLeaveList.
      notifyListeners();
      log("teamleavelist---$teamLeaveList");
    });
  }

  Future<int> LeaveBalance() async {
    var sickleave = 12;
    var Plannedleave = 8;
    log(" leave===${leave_list.length}");

    totalLeave = leave_list.length;
    for (int i = 1; i <= leave_list.length; i++) {
      if (leave_list.contains("Sick leave")) {
        sickleave = sickleave - 1;
        totalLeave = sickleave + Plannedleave;
      } else {
        Plannedleave = Plannedleave - 1;
        log("planned leave-- ${Plannedleave}");
        totalLeave = sickleave + Plannedleave;
      }
    }

    return totalLeave;
  }

// leave approval
  ApprovalRejection() {
    // approvel_list = teamLeaveList.remove;
    var approved_list_lenth = teamLeaveList.length - approvel_list.length;
  }
}
