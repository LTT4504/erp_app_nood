import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../api/api_client.dart';
import '../../api/api_constant.dart';
import '../../models/model/response/attendance/attendance_status_response/attendance_status_response.dart';
import '../../models/model/response/attendance/attendance_status_response/attendance_history_response.dart';
import '../../models/model/response/attendance/checkin_response/checkin_response.dart';
import '../../models/model/response/attendance/checkout_reponse/checkout_response.dart';
import '../utils/logger/logger.dart';

class AttendanceService {
  static final Dio _dio = ApiClient.dio;

  static Future<AttendanceStatusResponse> fetchCurrentStatus() async {
    try {
      final response = await _dio.get(ApiConstant.attendanceStatus);
      log.i('Trạng thái hiện tại: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        return AttendanceStatusResponse.fromJson(data);
      } else {
        final message = response.data['message'] ?? 'Lỗi không xác định';
        throw Exception(message);
      }
    } catch (e, stackTrace) {
      log.e('Lỗi khi lấy trạng thái hiện tại', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  static Future<List<AttendanceHistoryData>> fetchHistory({
    String? startDate,
    String? endDate,
    int pageNumber = 1,
    int pageSize = 30,
  }) async {
    try {
      // Nếu không truyền startDate/endDate thì lấy 30 ngày gần nhất
      final now = DateTime.now();
      final start = startDate ?? DateFormat('yyyy-MM-dd').format(now.subtract(const Duration(days: 29)));
      final end = endDate ?? DateFormat('yyyy-MM-dd').format(now);
      final response = await _dio.get(
        ApiConstant.attendanceHistory,
        queryParameters: {
          'StartDate': start,
          'EndDate': end,
          'PageNumber': pageNumber,
          'PageSize': pageSize,
        },
      );
      log.i('Lịch sử chấm công: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final list = data != null && data['historyAttendanceCurrentUser'] is List
            ? data['historyAttendanceCurrentUser'] as List
            : [];
        return list.map((e) => AttendanceHistoryData.fromJson(e)).toList();
      } else {
        final message = response.data['message'] ?? 'Lỗi không xác định';
        throw Exception(message);
      }
    } catch (e, stackTrace) {
      log.e('Lỗi khi lấy lịch sử chấm công', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  static Future<CheckInResponse> checkIn() async {
    try {
      final response = await _dio.post(ApiConstant.checkIn);
      log.i('Check-in response: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        return CheckInResponse.fromJson(data);
      } else {
        String message = response.data['message'] ?? 'Check-in thất bại';
        // Nếu có errors, lấy details đầu tiên
        if (response.data['errors'] != null && response.data['errors'] is List && response.data['errors'].isNotEmpty) {
          final firstError = response.data['errors'][0];
          if (firstError is Map && firstError['details'] != null) {
            message = firstError['details'];
          }
        }
        throw Exception(message);
      }
    } catch (e, stackTrace) {
      log.e('Lỗi khi check-in', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  static Future<CheckOutResponse> checkOut() async {
    try {
      final response = await _dio.post(ApiConstant.checkOut);
      log.i('Check-out response: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        return CheckOutResponse.fromJson(data);
      } else {
        final message = response.data['message'] ?? 'Check-out thất bại';
        throw Exception(message);
      }
    } catch (e, stackTrace) {
      log.e('Lỗi khi check-out', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
