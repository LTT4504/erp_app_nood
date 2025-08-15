import 'package:get/get.dart';
import 'bank_salary_controller.dart';

class BankSalaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankSalaryController>(() => BankSalaryController());
  }
}
