import 'package:get/get.dart';

class NavigatorHelper {
  static Future<T?> to<T>(String route, {dynamic arguments}) async {
    return Get.toNamed<T>(route, arguments: arguments);
  }

  static void offAll(String route, {dynamic arguments}) {
    Get.offAllNamed(route, arguments: arguments);
  }

  static void back<T>({T? result}) {
    Get.back<T>(result: result);
  }
}
