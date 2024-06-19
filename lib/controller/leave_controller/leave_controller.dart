import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/leave_model/leave_model.dart';

class leave_controller with ChangeNotifier {
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
    };

    await collectionReference.add(data);
  }

  fetchData() {
    collectionReference.snapshots().listen((event) {
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
}
