import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/holiday_list/widgets/custom_holidaylist.dart';

class HolidayList extends StatelessWidget {
  const HolidayList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Holiday List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => Custom_HolidayList(),
          separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
          itemCount: 5),
    );
  }
}
