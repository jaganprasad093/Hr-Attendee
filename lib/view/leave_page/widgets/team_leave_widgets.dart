import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/leave_model/leave_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamLeave_widgets extends StatefulWidget {
  final LeaveModel leaveModel;

  const TeamLeave_widgets({
    super.key,
    required this.leaveModel,
  });

  @override
  State<TeamLeave_widgets> createState() => _TeamLeave_widgetsState();
}

class _TeamLeave_widgetsState extends State<TeamLeave_widgets> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  late Future<int> _reject;
  var accept = 0;
  // reject() async {
  //   SharedPreferences preff = await SharedPreferences.getInstance();
  //   await preff.setInt('leave_balance', 17);
  //   await preff.setInt('planned_leave', 7);
  //   await preff.setInt('sick_leave', 10);
  //   final int reject = preff.getInt('leave_balance')! - 1;
  //   setState(() {
  //     // _reject = preff.setInt("leave_balance", reject).then(bool sucess){
  //     //   return reject;
  //     // };
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                      "date",
                      style: TextStyle(),
                    ),
                    Text(
                      "${widget.leaveModel.start_date} to ${widget.leaveModel.end_date}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Center(
                        child: Text(
                      "Reject",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Center(
                        child: Text(
                      "Accept",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            )
          ],
        ),
        height: 170,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.2),
            borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
