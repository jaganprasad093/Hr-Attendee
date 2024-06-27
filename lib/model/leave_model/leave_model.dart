// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ffi';

class LeaveModel {
  String? title;
  String? leave_type;
  int? contact_no;
  String? start_date;
  String? end_date;
  String? reason;
  int? current_date;
  LeaveModel(
      {this.title,
      this.contact_no,
      this.end_date,
      this.leave_type,
      this.reason,
      this.start_date,
      this.current_date});
}
