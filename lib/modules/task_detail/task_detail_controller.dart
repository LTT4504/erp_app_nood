import 'package:get/get.dart';

class TaskDetailController extends GetxController {
  final task = {}.obs;

  @override
  void onInit() {
    super.onInit();
    // Lấy dữ liệu task được truyền qua arguments
    if (Get.arguments != null) {
      task.value = Get.arguments as Map<String, dynamic>;
    }
  }
}
