import 'package:flutter/material.dart';

class Custom_PersonalInformation extends StatefulWidget {
  const Custom_PersonalInformation({super.key});

  @override
  State<Custom_PersonalInformation> createState() =>
      _Custom_PersonalInformationState();
}

class _Custom_PersonalInformationState
    extends State<Custom_PersonalInformation> {
  @override
  static List<String> listOfPersonal_information = [
    "full name",
    "email address ",
    "phone.no",
    "address",
  ];
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          listOfPersonal_information[0],
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Text(
                      "sdfgh",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.2),
            borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
