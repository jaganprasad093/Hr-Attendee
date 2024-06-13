import 'package:flutter/material.dart';

class Check_in extends StatefulWidget {
  const Check_in({super.key});

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
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: Icon(Icons.exit_to_app_rounded)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Check in",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "date",
                  style: TextStyle(),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2:30",
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
            color: Colors.blue.withOpacity(.3),
            borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
