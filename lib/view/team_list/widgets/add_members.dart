import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/registration_model.dart/registration_model.dart';

class AddMember_widget extends StatelessWidget {
  const AddMember_widget({super.key, required this.registration_model});
  final Registration_model registration_model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      "haa",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      registration_model.email ?? "",
                      style: TextStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  width: 80,
                ),
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(child: Text("call")),
                      PopupMenuItem(
                          child: Text(
                        "delete",
                        style: TextStyle(color: Colors.red),
                      ))
                    ];
                  },
                )
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
