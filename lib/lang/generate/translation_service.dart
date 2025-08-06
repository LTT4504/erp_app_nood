import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'en_US.dart';
import 'vi_VN.dart';

class TranslationService extends Translations {
  static final _storage = GetStorage();
  static const _storageKey = 'language';

  // Danh sách các locale được hỗ trợ
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];

  // Locale mặc định fallback (khi không xác định được)
  static const Locale fallbackLocale = Locale('en', 'US');

  // Locale hiện tại lấy từ GetStorage hoặc mặc định
  static Locale get locale {
    final saved = _storage.read(_storageKey);
    if (saved != null && saved is String) {
      final parts = saved.split('_');
      if (parts.length == 2) {
        return Locale(parts[0], parts[1]);
      }
    }
    return const Locale('vi', 'VN'); // Locale mặc định nếu chưa lưu
  }

  // Hàm đổi ngôn ngữ và lưu lại
  static void changeLocale(Locale newLocale) {
    Get.updateLocale(newLocale);
    _storage.write(_storageKey, '${newLocale.languageCode}_${newLocale.countryCode}');
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'vi_VN': vi_VN,
      };
}
