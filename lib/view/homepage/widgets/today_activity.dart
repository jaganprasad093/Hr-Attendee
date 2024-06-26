import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Check_in extends StatefulWidget {
  const Check_in({super.key, required this.date, required this.checkin});
  final DateTime date;
  final bool checkin;

  @override
  State<Check_in> createState() => _Check_inState();
}

class _Check_inState extends State<Check_in> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Icon(
                    Icons.exit_to_app_rounded,
                    color: Colors.blue,
                  )),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.checkin ? "Check in" : "Check out",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      DateFormat("d/M/y").format(widget.date),
                      style: TextStyle(),
                    )
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat("h:m a").format(widget.date),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "on time",
                  style: TextStyle(),
                )
              ],
            ),
          ],
        ),
        height: 100,
        width: 200,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.1),
            borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
