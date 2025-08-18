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

  // User Profile
  static const String userMe = '/api/user/me';

  // Emergency Contact
  static const String emergencyContact = '/api/emergency-contact';

  // Education
  static const String education = '/api/education-info';
  // Bank & Salary
  static const String bankSalary = '/api/bank-salary';
}
