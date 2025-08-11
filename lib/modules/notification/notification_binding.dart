import 'package:get/get.dart';
import 'notification_controller.dart';

class PersonalNotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalNotificationsController>(() => PersonalNotificationsController());
  }
}
