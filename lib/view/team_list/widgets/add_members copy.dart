import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/registration_model/registration_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AddMember_withCall extends StatelessWidget {
  const AddMember_withCall({super.key, required this.registrationModel});
  final Registration_model registrationModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=600"),
                radius: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    registrationModel.firstname ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    registrationModel.email ?? "",
                    style: TextStyle(),
                  ),
                ],
              ),
              Spacer(),
              PopupMenuButton(
                onSelected: (value) async {
                  launchPhoneDialer("+919400130828");
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'call',
                      child: Text("Call"),
                    ),
                  ];
                },
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.2),
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunch(_phoneUri.toString()))
        await launch(_phoneUri.toString());
    } catch (error) {
      log("cannot dial");
      throw ("Cannot dial");
    }
  }
}
