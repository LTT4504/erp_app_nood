import 'package:get/get.dart';
import '../task/task_controller.dart';

class HomeController extends GetxController {
  final TaskController taskController = Get.put(TaskController());

  int currentTab = 0;

  void changeTab(int index) {
    currentTab = index;
    update();
  }
}
