import 'package:cloud_firestore/cloud_firestore.dart';

class Registration_model {
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? image;

  Registration_model(
      {this.firstname, this.lastname, this.email, this.password, this.image});

  factory Registration_model.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Registration_model(
      firstname: data['firstname'] as String?,
      lastname: data['lastname'] as String?,
      email: data['email'] as String?,
      password: data['password'] as String?,
    );
  }
}
