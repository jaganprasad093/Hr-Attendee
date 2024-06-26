import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/teamlist_controller/teamlist_controller.dart';
import 'package:flutter_application_1/model/registration_model/registration_model.dart';
import 'package:flutter_application_1/model/team_model/team_mode.dart';

import 'package:provider/provider.dart';

class AddMember_withAdd extends StatefulWidget {
  const AddMember_withAdd({super.key, required this.registrationModel});
  final Registration_model registrationModel;

  @override
  State<AddMember_withAdd> createState() => _AddMember_withAddState();
}

class _AddMember_withAddState extends State<AddMember_withAdd> {
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
                    widget.registrationModel.firstname ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.registrationModel.email ?? "",
                    style: TextStyle(),
                  ),
                ],
              ),
              Spacer(),
              PopupMenuButton(
                onSelected: (value) async {
                  if (value == 'add') {
                    final registrationModel = widget.registrationModel;
                    final teamlistController =
                        Provider.of<TeamlistController>(context, listen: false);

                    if (registrationModel != null) {
                      final teamModel = TeamModel(
                        team_list: registrationModel.firstname ?? 'Unknown',
                      );

                      try {
                        await teamlistController.addData(teamModel);
                        teamlistController.addMember(registrationModel);
                      } catch (e) {
                        print('Failed to add data: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to add member')),
                        );
                      }
                    } else {
                      print('Registration model is null');
                    }
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'add',
                      child: Text("Add"),
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
}
