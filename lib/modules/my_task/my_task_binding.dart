import 'package:get/get.dart';
import 'my_task_controller.dart';

class MyTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTaskController>(() => MyTaskController());
  }
}
