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
    loadData();
  }

  Future<void> fetchStatus() async {
    final result = await AttendanceService.fetchCurrentStatus();
    status.value = result;
  }

  Future<void> fetchHistory() async {
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 6));
    final historyResult = await AttendanceService.fetchHistory(
      startDate: DateFormat('yyyy-MM-dd').format(start),
      endDate: DateFormat('yyyy-MM-dd').format(now),
    );
    history.assignAll(historyResult);
  }

  Future<void> checkIn() async {
    try {
      await AttendanceService.checkIn();
      await loadData();
    } catch (e) {
      Get.snackbar('Lỗi', 'Chấm công thất bại: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> checkOut() async {
    await AttendanceService.checkOut();
    await loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    await fetchStatus();
    await fetchHistory();
    isLoading.value = false;
  }
}
