import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/registration_controller/registration_controller.dart';
import 'package:flutter_application_1/view/team_list/widgets/add_members.dart';
import 'package:provider/provider.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({super.key});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add members",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<registration_controller>(
        builder: (context, value, child) => ListView.separated(
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AddMember_withAdd(
                    registrationModel: value.users_list[index],
                  ),
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
            itemCount: value.users_list.length),
      ),
    );
  }
}
