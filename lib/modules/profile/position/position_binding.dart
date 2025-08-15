import 'package:get/get.dart';
import 'position_controller.dart';

class PositionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PositionController>(() => PositionController());
  }
}
