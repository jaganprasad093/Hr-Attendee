import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/view/profile/personal_information/widgets/personal_documents.dart';
import 'package:flutter_application_1/view/profile/personal_information/widgets/personal_information_widget.dart';

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
                    text: "Personal",
                  ),
                  Tab(
                    text: "Proffestional",
                  ),
                  Tab(
                    text: "Documents",
                  ),
                ]),
            Expanded(
              child: TabBarView(children: [
                ListView.separated(
                    itemBuilder: (context, index) =>
                        Custom_PersonalInformation(),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: 5),
                ListView.separated(
                    itemBuilder: (context, index) =>
                        Custom_PersonalInformation(),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: 10),
                ListView.separated(
                    itemBuilder: (context, index) =>
                        Custom_PersonalDoucuments(),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: 3),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
