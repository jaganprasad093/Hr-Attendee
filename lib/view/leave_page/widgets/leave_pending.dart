import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/leave_controller/leave_controller.dart';
import 'package:flutter_application_1/view/leave_page/widgets/custom_leave_widgets.dart';
import 'package:flutter_application_1/view/leave_page/widgets/leave_details.dart';
import 'package:provider/provider.dart';

class LeavePending extends StatefulWidget {
  const LeavePending({super.key});

  @override
  State<LeavePending> createState() => _LeavePendingState();
}

class _LeavePendingState extends State<LeavePending> {
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
          "Leave Pending",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                                      leaveModel: value.leave_list[index]),
                                ));
                          },
                          child: Custom_leave_widgets(
                              leaveModel: value.leave_list[index]),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: value.leave_list.length)),
          ],
        ),
      ),
    );
  }
}
