import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/registration_controller/registration_controller.dart';
import 'package:flutter_application_1/model/registration_model/registration_model.dart';
import 'package:flutter_application_1/view/profile/profile.dart';
import 'package:provider/provider.dart';

class EditName extends StatelessWidget {
  const EditName({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController NameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Name",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  context
                      .read<registration_controller>()
                      .updateName(Registration_model(
                        firstname: NameController.text,
                      ));
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
                  controller: NameController,
                  decoration: const InputDecoration(
                    labelText: 'Edit name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter a name'
                        : null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
