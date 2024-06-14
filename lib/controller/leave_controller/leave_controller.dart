import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/leave_model/leave_model.dart';

class leave_controller with ChangeNotifier {
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
}
