import 'package:dio/dio.dart';
import '../../api/api_client.dart';
import '../../api/api_constant.dart';
import '../../models/model/response/attendance/attendance_status_response/attendance_history_response.dart';
import '../../models/model/response/attendance/attendance_status_response/attendance_status_response.dart';
import '../../models/model/response/attendance/checkin_response/checkin_response.dart';
import '../../models/model/response/attendance/checkout_reponse/checkout_response.dart';
import '../utils/logger/logger.dart';

class AttendanceService {
  static final Dio _dio = ApiClient.dio;

  static Future<CheckInResponse> checkIn() async {
    try {
      final response = await _dio.post(ApiConstant.checkIn);
      return CheckInResponse.fromJson(response.data);
    } catch (e, stackTrace) {
      log.e('Check-in failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  static Future<CheckOutResponse> checkOut() async {
    try {
      final response = await _dio.post(ApiConstant.checkOut);
      return CheckOutResponse.fromJson(response.data);
    } catch (e, stackTrace) {
      log.e('Check-out failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  static Future<AttendanceStatusResponse> getStatus() async {
    try {
      final response = await _dio.get(ApiConstant.attendanceStatus);
      return AttendanceStatusResponse.fromJson(response.data);
    } catch (e, stackTrace) {
      log.e('Get status failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  static Future<List<AttendanceHistoryData>> getHistory({
    required String startDate,
    required String endDate,
    int pageNumber = 1,
    int pageSize = 7,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstant.attendanceHistory,
        queryParameters: {
          'StartDate': startDate,
          'EndDate': endDate,
          'PageNumber': pageNumber,
          'PageSize': pageSize,
        },
      );

      final data = response.data['data'];
      if (data is List) {
        return data.map((e) => AttendanceHistoryData.fromJson(e)).toList();
      } else {
        log.w('⚠️ Unexpected data format in attendance history');
        return [];
      }
    } catch (e, stackTrace) {
      log.e('❌ Get history failed', error: e, stackTrace: stackTrace);
      return [];
    }
  }
}
