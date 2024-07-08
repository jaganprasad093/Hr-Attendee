import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/leave_model/leave_model.dart';

class LeaveDetails extends StatelessWidget {
  final LeaveModel leaveModel;
  const LeaveDetails({super.key, required this.leaveModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Leave details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              width: 400,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(.5)),
                  ),
                  Text(
                    leaveModel.title ?? "",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              width: 400,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Leave type",
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(.5)),
                  ),
                  Text(
                    leaveModel.leave_type ?? "not added",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              width: 400,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(.5)),
                  ),
                  Text(
                    leaveModel.start_date ?? "not added",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              width: 400,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reason",
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(.5)),
                  ),
                  Text(
                    leaveModel.reason ?? "*not added",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              width: 400,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "contact number",
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(.5)),
                  ),
                  Text(
                    " ${leaveModel.contact_no}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              width: 400,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "status",
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(.5)),
                  ),
                  Text(
                    leaveModel.status ?? "*not added",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ],
      ),
    );
  }
}
