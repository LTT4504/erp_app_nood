import 'package:get/get.dart';

class ProjectDetailController extends GetxController {
  var project = {}.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      project.value = Get.arguments; // lấy dữ liệu từ ProjectScreen truyền qua
    }
  }
}
