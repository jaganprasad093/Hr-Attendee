import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/registration_model/registration_model.dart';
import 'package:image_picker/image_picker.dart';

class registration_controller with ChangeNotifier {
  bool isLoading = false;
  bool uploading = false;
  var collectionReference = FirebaseFirestore.instance.collection("users");

  Registration_model? user;
  List<Registration_model> users_list = [];
  final ImagePicker picker = ImagePicker();

  File? selectedFile;

  registration_controller() {
    addRegisterListener();
    // addUsersList();
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("The password provided is too weak.")));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("The account already exists for that email.")));
      }
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      log(e.toString());
      isLoading = false;
      notifyListeners();
      return false;
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> addData(Registration_model registrationModel, String uid) async {
    final data = {
      "firstname": registrationModel.firstname,
      "lastname": registrationModel.lastname,
      "email": registrationModel.email,
      "password": registrationModel.password,
      "image": registrationModel.image,
      "userid": FirebaseAuth.instance.currentUser!.uid
    };

    await collectionReference.doc(uid).set(data);
  }

  void addRegisterListener() {
    if (FirebaseAuth.instance.currentUser != null) {
      collectionReference
          .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
          .snapshots()
          .listen((event) {
        final data = event.data();
        if (data != null) {
          user = Registration_model(
            firstname: data["firstname"] as String? ?? '',
            lastname: data["lastname"] as String? ?? '',
            email: data["email"],
            password: data["password"] as String? ?? '',
          );
        }
        notifyListeners();
      }, onError: (error) {
        log("Error fetching snapshots: $error");
      });
    }
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
      log("Fetched ${users_list.length} users");
      notifyListeners();
    }, onError: (error) {
      log("Error fetching snapshots: $error");
    });
  }

  Future<void> fetchUserData() async {
    collectionReference
        .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("users", descending: true)
        .snapshots()
        .listen((event) {
      users_list = event.docs
          .map((e) => Registration_model(
                firstname: e['firstname'],
                lastname: e['lastname'],
                email: e['email'],
                password: e['password'],
              ))
          .toList();
      notifyListeners();
    });
  }

  Future<void> pickImageFromCamera() async {
    final XFile? img = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 400,
    );
    if (img != null) {
      selectedFile = File(img.path);
      notifyListeners();
    }
  }

  Future<void> pickImageFromGallery() async {
    final XFile? img = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
    );
    if (img != null) {
      selectedFile = File(img.path);
      notifyListeners();
    }
  }

  void resetData() {
    users_list.clear();
    user = null;
    notifyListeners();
  }
}
