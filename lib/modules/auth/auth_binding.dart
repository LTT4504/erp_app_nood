import 'package:get/get.dart';
import 'package:work_manager/modules/home/home.dart';
import 'auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
  }
  
}
