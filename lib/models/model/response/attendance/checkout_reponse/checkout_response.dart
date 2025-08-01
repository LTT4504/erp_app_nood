class CheckOutResponse {
  final bool success;
  final String? message;

  CheckOutResponse({required this.success, this.message});

  factory CheckOutResponse.fromJson(Map<String, dynamic> json) {
    return CheckOutResponse(
      success: json['success'] ?? false,
      message: json['message'],
    );
  }
}
