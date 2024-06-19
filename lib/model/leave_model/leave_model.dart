// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LeaveModel {
  String? title;
  String? leave_type;
  int? contact_no;
  String? start_date;
  String? end_date;
  String? reason;
  LeaveModel({
    this.title,
    this.contact_no,
    this.end_date,
    this.leave_type,
    this.reason,
    this.start_date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'leave_type': leave_type,
      'contact_no': contact_no,
      'start_date': start_date,
      'end_date': end_date,
      'reason': reason,
    };
  }

  factory LeaveModel.fromMap(Map<String, dynamic> map) {
    return LeaveModel(
      title: map['title'] != null ? map['title'] as String : null,
      leave_type:
          map['leave_type'] != null ? map['leave_type'] as String : null,
      contact_no: map['contact_no'] != null ? map['contact_no'] as int : null,
      start_date:
          map['start_date'] != null ? map['start_date'] as String : null,
      end_date: map['end_date'] != null ? map['end_date'] as String : null,
      reason: map['reason'] != null ? map['reason'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaveModel.fromJson(String source) =>
      LeaveModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
