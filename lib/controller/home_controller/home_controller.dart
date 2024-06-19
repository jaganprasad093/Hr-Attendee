import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
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
  // }
}
