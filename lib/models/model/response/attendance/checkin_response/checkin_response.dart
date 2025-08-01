class CheckInResponse {
  final bool success;
  final String? message;

  CheckInResponse({required this.success, this.message});

  factory CheckInResponse.fromJson(Map<String, dynamic> json) {
    return CheckInResponse(
      success: json['success'] ?? false,
      message: json['message'],
    );
  }
}
