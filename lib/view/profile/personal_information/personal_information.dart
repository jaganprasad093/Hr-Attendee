import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/registration_controller/registration_controller.dart';
import 'package:flutter_application_1/model/registration_model/registration_model.dart';
import 'package:flutter_application_1/view/profile/personal_information/widgets/personal_documents.dart';
import 'package:flutter_application_1/view/profile/personal_information/widgets/personal_information/personal_information_widget.dart';
import 'package:flutter_application_1/view/profile/personal_information/widgets/proffestional_informations.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "My Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            TabBar(
                onTap: (value) {
                  setState(() {
                    currentTabIndex = value;
                  });
                },
                tabs: [
                  Tab(
                    child: Container(
                      height: 50,
                      width: 100,
                      child: Center(
                          child: Text(
                        "Personal",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: currentTabIndex == 0
                              ? Colors.white
                              : Colors.black,
                        ),
                      )),
                      decoration: BoxDecoration(
                          color:
                              currentTabIndex == 0 ? Colors.blue : Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 50,
                      width: 100,
                      child: Center(
                          child: Text(
                        "Proffestional",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: currentTabIndex == 1
                              ? Colors.white
                              : Colors.black,
                        ),
                      )),
                      decoration: BoxDecoration(
                          color:
                              currentTabIndex == 1 ? Colors.blue : Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 50,
                      width: 110,
                      child: Center(
                          child: Text(
                        "Documents",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: currentTabIndex == 2
                              ? Colors.white
                              : Colors.black,
                        ),
                      )),
                      decoration: BoxDecoration(
                          color:
                              currentTabIndex == 2 ? Colors.blue : Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ]),
            Expanded(
              child: TabBarView(children: [
                // Consumer<registration_controller>(
                //     builder: (context, value, child) {
                //   print("user list--${value.users_list.length}");

                //   if (value.users_list.length > 1) {
                //     return Custom_PersonalInformation(
                //       registrationmodel: value.users_list[1],
                //     );
                //   } else {
                //     return Center(
                //       child: Text("Not enough data available"),
                //     );
                //   }
                // }),
                Custom_PersonalInformation(
                    registrationmodel: Registration_model()),
                Consumer<registration_controller>(
                    builder: (context, value, child) =>
                        Proffestional_informations()),
                ListView.separated(
                    itemBuilder: (context, index) =>
                        Custom_PersonalDoucuments(),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: 2),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
