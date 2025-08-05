class AttendanceHistoryData {
  final int id;
  final String? workDay;
  final String? checkInOn;
  final String? checkOutOn;
  final String? note;

  AttendanceHistoryData({
    required this.id,
    this.workDay,
    this.checkInOn,
    this.checkOutOn,
    this.note,
  });

  factory AttendanceHistoryData.fromJson(Map<String, dynamic> json) {
    return AttendanceHistoryData(
      id: json['id'] ?? 0,
      workDay: json['workDay'],
      checkInOn: json['checkInOn'],
      checkOutOn: json['checkOutOn'],
      note: json['note'],
    );
  }
}
