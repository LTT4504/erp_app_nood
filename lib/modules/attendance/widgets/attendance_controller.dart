// widgets/attendance_controller.dart

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/model/response/attendance/attendance_status_response/attendance_history_response.dart';
import '../../../models/model/response/attendance/attendance_status_response/attendance_status_response.dart';
import '../../../shared/services/attendance_service.dart';

class AttendanceController extends GetxController {
  var status = Rxn<AttendanceStatusResponse>();
  var history = <AttendanceHistoryData>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStatus();
    fetchHistory();
  }

  Future<void> fetchStatus() async {
    isLoading.value = true;
    final result = await AttendanceService.getStatus();
    status.value = result;
    isLoading.value = false;
  }

Future<void> fetchHistory() async {
  isLoading.value = true;
  final now = DateTime.now();
  final start = now.subtract(const Duration(days: 6));
  final historyResult = await AttendanceService.getHistory(
    startDate: DateFormat('yyyy-MM-dd').format(start),
    endDate: DateFormat('yyyy-MM-dd').format(now),
  );
  history.assignAll(historyResult); // giờ đã đúng kiểu List<>
  isLoading.value = false;
}


  Future<void> checkIn() async {
    await AttendanceService.checkIn();
    await fetchStatus();
    await fetchHistory();
  }

  Future<void> checkOut() async {
    await AttendanceService.checkOut();
    await fetchStatus();
    await fetchHistory();
  }
}
