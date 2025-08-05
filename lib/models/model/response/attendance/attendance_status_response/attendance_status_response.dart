class AttendanceStatusResponse {
  final bool checkIn;
  final bool checkOut;
  final String? checkInDateTime;
  final String? checkOutDateTime;

  AttendanceStatusResponse({
    required this.checkIn,
    required this.checkOut,
    this.checkInDateTime,
    this.checkOutDateTime,
  });

  factory AttendanceStatusResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceStatusResponse(
      checkIn: json['checkIn'] ?? false,
      checkOut: json['checkOut'] ?? false,
      checkInDateTime: json['checkInDateTime'],
      checkOutDateTime: json['checkOutDateTime'],
    );
  }

  bool get canCheckIn => !checkIn;

  bool get canCheckOut => checkIn && !checkOut;

  DateTime? get checkInTime {
    if (checkInDateTime == null) return null;
    return DateTime.tryParse(checkInDateTime!);
  }

  DateTime? get checkOutTime {
    if (checkOutDateTime == null) return null;
    return DateTime.tryParse(checkOutDateTime!);
  }

  bool get checkedIn => checkInTime != null;

  bool get checkedOut => checkOutTime != null;
}
