import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/registration_controller/registration_controller.dart';
import 'package:flutter_application_1/model/registration_model/registration_model.dart';
import 'package:flutter_application_1/view/profile/profile.dart';
import 'package:provider/provider.dart';

class PhonenoEdit extends StatelessWidget {
  const PhonenoEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController PhoneController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Phone No",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  context
                      .read<registration_controller>()
                      .collectionReference
                      .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
                      .update({
                    "phoneno": PhoneController.text,
                  });
                  Navigator.pop(context);
                }
              },
              child: Icon(Icons.check, color: Colors.blue, size: 30)),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextFormField(
                  controller: PhoneController,
                  decoration: const InputDecoration(
                    labelText: 'Edit phone no',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null ||
                            value.isEmpty ||
                            !RegExp(r'^[0-9]{10}$').hasMatch(value))
                        ? 'Please enter a valid 10-digit contact number'
                        : null;
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
