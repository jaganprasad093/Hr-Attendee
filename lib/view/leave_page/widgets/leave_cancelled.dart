import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/leave_controller/leave_controller.dart';
import 'package:flutter_application_1/view/leave_page/widgets/custom_leave_widgets.dart';
import 'package:provider/provider.dart';

class Leave_cancelled extends StatefulWidget {
  const Leave_cancelled({super.key});

  @override
  State<Leave_cancelled> createState() => _Leave_cancelledState();
}

class _Leave_cancelledState extends State<Leave_cancelled> {
  @override
  void initState() {
    context.read<leave_controller>().CancelledGetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Leave cancelled",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Consumer<leave_controller>(
              builder: (context, value, child) => ListView.separated(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Custom_leave_widgets(
                        leaveModel: value.canceled_list[index]);
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: value.canceled_list.length)),
        ],
      ),
    );
  }
}
