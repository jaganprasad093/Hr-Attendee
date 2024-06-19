import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/leave_controller/leave_controller.dart';
import 'package:flutter_application_1/model/leave_model/leave_model.dart';
import 'package:flutter_application_1/view/bottom_navigation/bottom_navigation.dart';
import 'package:provider/provider.dart';

class ApplyLeave extends StatefulWidget {
  const ApplyLeave({super.key});

  @override
  _ApplyLeaveState createState() => _ApplyLeaveState();
}

class _ApplyLeaveState extends State<ApplyLeave> {
  TextEditingController titleController = TextEditingController();
  TextEditingController leaveTypeController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  DateTime selectedDate = DateTime.now();

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
                  "Leave Applied\n   successfully",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                Text(
                  " Your leave has been applied successfully",
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

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024, 1),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String convertedDateTime =
            "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        controller.value = TextEditingValue(text: convertedDateTime);
      });
    }
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
          child: Icon(Icons.arrow_back),
        ),
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
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
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
                  controller: leaveTypeController,
                  decoration: const InputDecoration(
                    labelText: 'Leave type',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
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
                  controller: contactController,
                  decoration: const InputDecoration(
                    labelText: 'Contact number',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
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
                  controller: startDateController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.date_range_outlined),
                    labelText: 'Start date',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context, startDateController),
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
                  controller: endDateController,
                  decoration: const InputDecoration(
                    labelText: 'End date',
                    suffixIcon: Icon(Icons.date_range_outlined),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context, endDateController),
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
                  controller: reasonController,
                  decoration: const InputDecoration(
                    labelText: 'Reason',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
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
                  onTap: () async {
                    // await context.read<leave_controller>().addData(LeaveModel(
                    //     title: titleController.text,
                    //     contact_no: int.tryParse(contactController.text),
                    //     end_date: endDateController.text,
                    //     start_date: startDateController.text,
                    //     leave_type: leaveTypeController.text,
                    //     reason: reasonController.text));
                    // log("sucess");
                    // if (_formKey.currentState!.validate()) {
                    //   showDialogWithFields(context);
                    // }
                    // ScaffoldMessenger.of(context)
                    //     .showSnackBar(SnackBar(content: Text("sucess")));
                    // Navigator.pop(context);
                    if (_formKey.currentState!.validate()) {
                      await context.read<leave_controller>().addData(LeaveModel(
                            title: titleController.text,
                            contact_no: int.tryParse(contactController.text),
                            end_date: endDateController.text,
                            start_date: startDateController.text,
                            leave_type: leaveTypeController.text,
                            reason: reasonController.text,
                          ));
                      log("sucess");
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("sucess")));

                      showDialogWithFields(context);
                      Navigator.pop(context);
                    } else {}
                  },
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Apply leave",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
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
