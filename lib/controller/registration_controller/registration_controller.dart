import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/registration_model/registration_model.dart';

class registration_controller with ChangeNotifier {
  bool isLoading = false;
  var collectionReference = FirebaseFirestore.instance.collection("users");
  Registration_model? user;
  List<Registration_model> users_list = [];
  registration_controller() {
    addRegisterListener();
    addUsersList();
  }
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

  Future addData(Registration_model registration_model, String uid) async {
    final data = {
      "firstname": registration_model.firstname,
      "lastname": registration_model.lastname,
      "email": registration_model.email,
      "password": registration_model.password,
    };

    await collectionReference.doc(uid).set(data);
  }

  void addRegisterListener() {
    collectionReference
        .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
        .snapshots()
        .listen((event) {
      // user= event.docs.map((e) {
      final data = event.data();
      user = Registration_model(
        firstname: data?["firstname"] as String? ?? '',
        lastname: data?["lastname"] as String? ?? '',
        email: data?["email"],
        password: data?["password"] as String? ?? '',
      );
      // }).toList();
      notifyListeners();
    }, onError: (error) {
      // Handle errors here
      print("Error fetching snapshots: $error");
    });
  }

  void addUsersList() {
    collectionReference.snapshots().listen((event) {
      users_list = event.docs.map((e) {
        final data = e.data();
        return Registration_model(
          firstname: data?["firstname"] as String? ?? '',
          lastname: data?["lastname"] as String? ?? '',
          email: data?["email"],
          password: data?["password"] as String? ?? '',
        );
      }).toList();
      notifyListeners();
    }, onError: (error) {
      // Handle errors here
      print("Error fetching snapshots: $error");
    });
  }

  Future<Registration_model?> fetchUserData(String uid) async {
    try {
      DocumentSnapshot doc = await collectionReference.doc(uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return Registration_model(
          firstname: data['firstname'],
          lastname: data['lastname'],
          email: data['email'],
          password: data['password'],
        );
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return null;
  }
}
