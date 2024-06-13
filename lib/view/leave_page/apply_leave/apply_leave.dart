import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/bottom_navigation/bottom_navigation.dart';
import 'package:flutter_application_1/view/leave_page/leave_page.dart';

class ApplyLeave extends StatefulWidget {
  const ApplyLeave({super.key});

  @override
  _ApplyLeaveState createState() => _ApplyLeaveState();
}

class _ApplyLeaveState extends State<ApplyLeave> {
  final _formKey = GlobalKey<FormState>();

  void showDialogWithFields(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Container(
            height: 230,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8IfpQnbAsIBukGbQmWb2Qwaeihp2Ka0QjpA&s"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Leave Applied\n   sucessfully",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                Text(
                  " Your has been leave applied sucessfully",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(.5),
                      fontSize: 15),
                )
              ],
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavigation(),
                    ));
              },
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Apply leave",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter a title'
                        : null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Leave type',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter the type of leave'
                        : null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Contact number',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null ||
                            value.isEmpty ||
                            !RegExp(r'^[0-9]+$').hasMatch(value))
                        ? 'Please enter a valid contact number'
                        : null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Start date',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter the start date'
                        : null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'End date',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter the end date'
                        : null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Reason',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter the reason for leave'
                        : null;
                  },
                ),
                SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      showDialogWithFields(context);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Apply leave",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
