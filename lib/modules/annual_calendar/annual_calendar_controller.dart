import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AnnualCalendarController extends GetxController {
  final storage = GetStorage();
  final selectedDate = DateTime.now().obs;
  final meetings = <Map<String, dynamic>>[].obs;

  static const _storageKey = 'meetings';

  @override
  void onInit() {
    super.onInit();
    _safeLoadMeetings();

    // Ghi dữ liệu xuống storage mỗi khi meetings thay đổi
    ever<List<Map<String, dynamic>>>(meetings, (list) {
      storage.write(_storageKey, list.map((m) => Map<String, dynamic>.from(m)).toList());
    });
  }

  /// Load dữ liệu từ storage
  void _safeLoadMeetings() {
    try {
      final raw = storage.read<List>(_storageKey);
      if (raw != null && raw.isNotEmpty) {
        final parsed = raw.map((e) => Map<String, dynamic>.from(e as Map)).toList();
        meetings.assignAll(parsed);
      }
    } catch (e) {
      print("Lỗi load meetings: $e");
    }
  }

  /// Chọn ngày
  void onDateSelected(DateTime selectedDay, DateTime focusedDay) {
    selectedDate.value = selectedDay;
  }

  /// Thêm meeting
  void addMeeting(Map<String, dynamic> meeting) {
    final plain = Map<String, dynamic>.from(meeting);
    meetings.add(plain);
  }

  /// Xóa meeting
  void removeMeetingAt(int index) {
    if (index >= 0 && index < meetings.length) {
      meetings.removeAt(index);
    }
  }
}
