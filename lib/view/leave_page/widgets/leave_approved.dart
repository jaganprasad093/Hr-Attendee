import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/leave_controller/leave_controller.dart';
import 'package:flutter_application_1/view/leave_page/widgets/custom_leave_widgets.dart';
import 'package:flutter_application_1/view/leave_page/widgets/leave_details.dart';
import 'package:provider/provider.dart';

class Leave_approved extends StatefulWidget {
  const Leave_approved({super.key});

  @override
  State<Leave_approved> createState() => _Leave_approvedState();
}

class _Leave_approvedState extends State<Leave_approved> {
  @override
  void initState() {
    context.read<leave_controller>().ApprovelGetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Leave Approved",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Consumer<leave_controller>(
              builder: (context, value, child) => ListView.separated(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LeaveDetails(
                                    leaveModel: value.approvel_list[index]),
                              ));
                        },
                        child: Custom_leave_widgets(
                            leaveModel: value.approvel_list[index]),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: value.approvel_list.length)),
        ],
      ),
    );
  }
}
