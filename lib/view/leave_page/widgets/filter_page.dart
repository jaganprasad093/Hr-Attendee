import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/leave_controller/leave_controller.dart';
import 'package:flutter_application_1/view/leave_page/widgets/custom_leave_widgets.dart';
import 'package:provider/provider.dart';

class CustomFilterPage extends StatefulWidget {
  const CustomFilterPage({super.key});

  @override
  State<CustomFilterPage> createState() => _CustomFilterPageState();
}

class _CustomFilterPageState extends State<CustomFilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text("asdfg"),
      ),
      body: Consumer<leave_controller>(builder: (context, value, child) {
        log("value--${value.filteredLeaveList.length.toString()}");
        return Consumer<leave_controller>(
          builder: (context, value, child) => ListView.separated(
              itemBuilder: (context, index) {
                log("value--${value.filteredLeaveList.length.toString()}");
                return Custom_leave_widgets(
                  leaveModel: value.filteredLeaveList[index],
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              itemCount: value.filteredLeaveList.length),
        );
      }),
    );
  }
}
