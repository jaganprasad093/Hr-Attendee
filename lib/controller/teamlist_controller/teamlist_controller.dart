import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/registration_model/registration_model.dart';
import 'package:flutter_application_1/model/team_model/team_mode.dart';

class TeamlistController with ChangeNotifier {
  List<Registration_model> addMember_list = [];
  List<TeamModel> memberList = [];
  var collectionReference = FirebaseFirestore.instance.collection("leave");

  // Adding data to Firebase
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addData(TeamModel teamModel) async {
    await firestore.collection('teams').add(teamModel.toMap());
    notifyListeners();
  }

  fetchData() {
    collectionReference
        .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      memberList = event.docs
          .map((e) => TeamModel(
                team_list: e[""],
              ))
          .toList();
      notifyListeners();
    });
  }

  // Adding members to team members
  void addMember(Registration_model member) {
    addMember_list.add(member);
    notifyListeners();
  }

  // Removing members from add members
  void removeMember(Registration_model member) {
    addMember_list.remove(member);
    notifyListeners();
  }
}
