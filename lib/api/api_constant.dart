// api/api_constant.dart

class ApiConstant {
  static const String baseUrl = 'http://103.98.152.50:5999';

  // Auth
  static const String login = '/api/auth/login';
  static const String refreshToken = '/api/auth/refresh-token';
  static const String logout = '/api/auth/logout';
  static const String forgotPassword = '/api/auth/forgot-password';

  // Attendance
  static const String checkIn = '/api/attendance/check-in';
  static const String checkOut = '/api/attendance/check-out';
  static const String attendanceStatus = '/api/attendance/status';
  static const String attendanceHistory = '/api/attendance/history';
  static const String attendancePost = '/api/attendance';
}
