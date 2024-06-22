import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/registration_model/registration_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AddMemberWidget extends StatelessWidget {
  const AddMemberWidget({super.key, required this.registrationModel});
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
                onSelected: (value) {
                  if (value == 'call') {
                    dialNumber(phoneNumber: "1234567890", context: context);
                  }
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

  Future<void> dialNumber(
      {required String phoneNumber, required BuildContext context}) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Unable to call $phoneNumber")));
    }
  }
}
