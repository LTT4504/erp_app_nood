import 'package:get/get.dart';
import '../../../lang/app_language_key.dart';

class MyTaskController extends GetxController {
  final tasks = [
    {
      'title': AppLanguageKey.interfaceDesign.tr, // chỉ lưu key
      'project': AppLanguageKey.projectA.tr,
      'priority': AppLanguageKey.low.tr,
      'progress': 40,
      'datetime': '2025-08-14',
    },
    {
      'title': AppLanguageKey.writeApi.tr,
      'project': AppLanguageKey.projectB.tr,
      'priority': AppLanguageKey.low.tr,
      'progress': 75,
      'datetime': '2025-08-20',
    },
    {
      'title': AppLanguageKey.systemTesting.tr,
      'project': AppLanguageKey.projectC.tr,
      'priority': AppLanguageKey.low.tr,
      'progress': 20,
      'datetime': '2025-08-25',
    },
  ].obs;

  final filteredTasks = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredTasks.assignAll([
      {
        'title': AppLanguageKey.interfaceDesign.tr, // chỉ lưu key
        'project': AppLanguageKey.projectA.tr,
        'priority': AppLanguageKey.low.tr,
        'progress': 40,
        'datetime': '2025-08-14',
      },
      {
        'title': AppLanguageKey.writeApi.tr,
        'project': AppLanguageKey.projectB.tr,
        'priority': AppLanguageKey.low.tr,
        'progress': 75,
        'datetime': '2025-08-20',
      },
      {
        'title': AppLanguageKey.systemTesting.tr,
        'project': AppLanguageKey.projectC.tr,
        'priority': AppLanguageKey.low.tr,
        'progress': 20,
        'datetime': '2025-08-25',
      },
    ]);
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredTasks.assignAll(tasks);
    } else {
      filteredTasks.assignAll(
        tasks.where(
          (task) => task['title.tr']
              .toString()
              .tr
              .toLowerCase()
              .contains(query.toLowerCase()),
        ),
      );
    }
  }
}
