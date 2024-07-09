import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/registration_controller/registration_controller.dart';
import 'package:flutter_application_1/model/registration_model/registration_model.dart';
import 'package:provider/provider.dart';

class Custom_PersonalInformation extends StatefulWidget {
  const Custom_PersonalInformation(
      {super.key, required this.registrationmodel});
  final Registration_model registrationmodel;

  @override
  State<Custom_PersonalInformation> createState() =>
      _Custom_PersonalInformationState();
}

class _Custom_PersonalInformationState
    extends State<Custom_PersonalInformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            width: 400,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "first name",
                  style: TextStyle(
                      fontSize: 15, color: Colors.black.withOpacity(.5)),
                ),
                Consumer<registration_controller>(
                  builder: (context, value, child) => Text(
                    context.read<registration_controller>().user?.firstname ??
                        "Name",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(14)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            width: 400,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email adress",
                  style: TextStyle(
                      fontSize: 15, color: Colors.black.withOpacity(.5)),
                ),
                Consumer<registration_controller>(
                  builder: (context, value, child) => Text(
                    //   context.read<registration_controller>().user?.email ??
                    value.user?.email ?? "email adress",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(14)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            width: 400,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "phone ",
                  style: TextStyle(
                      fontSize: 15, color: Colors.black.withOpacity(.5)),
                ),
                Consumer<registration_controller>(
                  builder: (context, value, child) => Text(
                    "*not added",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(14)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            width: 400,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address",
                  style: TextStyle(
                      fontSize: 15, color: Colors.black.withOpacity(.5)),
                ),
                Text(
                  "*not added",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ],
    );
  }
}
