import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  final selectedLocale = const Locale('vi', 'VN').obs;

  void changeLanguage(Locale locale) {
    selectedLocale.value = locale;
    Get.updateLocale(locale);
    update();
  }
}
