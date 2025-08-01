class AttendanceStatusResponse {
  final bool isCheckedIn;
  final String? lastCheckInTime;
  final String? lastCheckOutTime;

  AttendanceStatusResponse({
    required this.isCheckedIn,
    this.lastCheckInTime,
    this.lastCheckOutTime,
  });

  factory AttendanceStatusResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceStatusResponse(
      isCheckedIn: json['isCheckedIn'] ?? false,
      lastCheckInTime: json['lastCheckInTime'],
      lastCheckOutTime: json['lastCheckOutTime'],
    );
  }

  bool get canCheckOut =>
      isCheckedIn && lastCheckInTime != null && lastCheckOutTime == null;
}
