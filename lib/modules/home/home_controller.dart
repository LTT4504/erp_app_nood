import 'package:get/get.dart';

class HomeController extends GetxController {
  int currentTab = 0;

  void changeTab(int index) {
    currentTab = index;
    update();
  }
}
