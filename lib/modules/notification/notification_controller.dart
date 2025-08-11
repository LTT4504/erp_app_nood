import 'package:get/get.dart';

class PersonalNotificationsController extends GetxController {
  // Tab hiện tại
  final selectedTab = 0.obs;

  // Danh sách thông báo mẫu
  final leaveNotifications = <String>[].obs;
  final scheduleNotifications = <String>[].obs;
  final generalNotifications = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load thử dữ liệu (bỏ nếu muốn)
    // leaveNotifications.add("Your leave request was approved");
  }
}
