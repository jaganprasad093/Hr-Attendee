import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/registration_model.dart/registration_model.dart';

class registration_controller with ChangeNotifier {
  bool isLoading = false;
  var collectionReference = FirebaseFirestore.instance.collection("users");
  List<Registration_model> users_list = [];

  Future<bool> register({
    required BuildContext context,
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String repassword,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user?.uid != null) {
        collectionReference.doc(credential.user!.uid).set({
          "firstname": firstname,
          "lastname": lastname,
          "email": email,
          "password": password,
          "repassword": repassword
        });

        isLoading = false;
        notifyListeners();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("The password provided is too weak.")));
        isLoading = false;
        notifyListeners();
        return false;
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("The account already exists for that email.")));
        // print('The account already exists for that email.');
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
      return false;
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future addData(Registration_model registration_model) async {
    final data = {
      "firstname": registration_model.firstname,
      "lastname": registration_model.lastname,
      "email": registration_model.email,
      "password": registration_model.password,
    };

    await collectionReference.add(data);
  }

  void addRegisterListener() {
    collectionReference.snapshots().listen((event) {
      users_list = event.docs.map((e) {
        final data = e.data();
        return Registration_model(
          firstname: data["firstname"] as String? ?? '',
          lastname: data["lastname"] as String? ?? '',
          email: data["email"],
          password: data["password"] as String? ?? '',
        );
      }).toList();
      notifyListeners();
    }, onError: (error) {
      // Handle errors here
      print("Error fetching snapshots: $error");
    });
  }
}
