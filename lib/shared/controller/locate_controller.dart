import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleController extends GetxController {
  final box = GetStorage();

  final locale = const Locale('vi', 'VN').obs;

  Locale getLocale() {
    final langCode = box.read('lang_code') ?? 'vi';
    final countryCode = box.read('country_code') ?? 'VN';
    locale.value = Locale(langCode, countryCode);
    return locale.value;
  }

  void updateLocale(Locale newLocale) {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
    box.write('lang_code', newLocale.languageCode);
    box.write('country_code', newLocale.countryCode);
  }
}
