// models/auth_response.dart

class AuthResponse {
  final int status;
  final bool success;
  final String message;
  final AuthData data;

  AuthResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        status: json['status'],
        success: json['success'],
        message: json['message'] ?? '',
        data: AuthData.fromJson(json['data']),
      );
}

class AuthData {
  final String accessToken;
  final String refreshToken;

  AuthData({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );
}
