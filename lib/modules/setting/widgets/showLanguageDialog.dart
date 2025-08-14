import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/modules/my_task/my_task_controller.dart';
import '../../../shared/controller/locate_controller.dart';

void showLanguageDialog(BuildContext context) {
  final localeController = Get.find<LocaleController>();
  final currentLocale = localeController.locale.value;

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text('language'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.language,
                color: currentLocale.languageCode == 'vi'
                    ? Colors.red
                    : Colors.grey,
              ),
              title: const Text(
                'Tiếng Việt',
              ),
              trailing: currentLocale.languageCode == 'vi'
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                localeController.updateLocale(const Locale('vi', 'VN'));
                final myTaskController = Get.find<MyTaskController>();
                myTaskController.onInit();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: currentLocale.languageCode == 'en'
                    ? Colors.green
                    : Colors.grey,
              ),
              title: const Text('English'),
              trailing: currentLocale.languageCode == 'en'
                  ? const Icon(Icons.check, color: Colors.red)
                  : null,
              onTap: () {
                localeController.updateLocale(const Locale('en', 'US'));
                final myTaskController = Get.find<MyTaskController>();
                myTaskController.onInit();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      );
    },
  );
}
