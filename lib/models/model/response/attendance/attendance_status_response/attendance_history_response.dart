class AttendanceHistoryResponse {
  final bool? success;
  final List<AttendanceHistoryData>? data;

  AttendanceHistoryResponse({this.success, this.data});

  factory AttendanceHistoryResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceHistoryResponse(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AttendanceHistoryData.fromJson(e))
          .toList(),
    );
  }
}

class AttendanceHistoryData {
  final String? checkInTime;
  final String? checkOutTime;
  final String? date;

  AttendanceHistoryData({this.checkInTime, this.checkOutTime, this.date});

  factory AttendanceHistoryData.fromJson(Map<String, dynamic> json) {
    return AttendanceHistoryData(
      checkInTime: json['checkInTime'] as String?,
      checkOutTime: json['checkOutTime'] as String?,
      date: json['date'] as String?,
    );
  }
}
