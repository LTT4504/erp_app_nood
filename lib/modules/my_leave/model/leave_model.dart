class LeaveModel {
  final String title;
  final String date;
  final String status;
  final int statusColor;
  final String reason;
  final String days;

  LeaveModel({
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.reason,
    required this.days,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
        title: json['title'],
        date: json['date'],
        status: json['status'],
        statusColor: json['statusColor'],
        reason: json['reason'],
        days: json['days'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'date': date,
        'status': status,
        'statusColor': statusColor,
        'reason': reason,
        'days': days,
      };
}
