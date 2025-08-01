class AttendanceRequest {
  final int id;

  AttendanceRequest({required this.id});

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}
