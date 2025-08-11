import 'package:get/get.dart';
import 'annual_calendar_controller.dart';

class AnnualCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnnualCalendarController>(() => AnnualCalendarController());
  }
}
