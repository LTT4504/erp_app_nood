// widgets/attendance_bindings.dart

import 'package:get/get.dart';
import 'attendance_controller.dart';

class AttendanceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceController());
  }
}
