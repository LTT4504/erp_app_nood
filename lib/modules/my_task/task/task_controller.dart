import 'package:get/get.dart';

class TaskController extends GetxController {
  final RxList<Map<String, dynamic>> tasks = <Map<String, dynamic>>[
    {
      'title': 'Feature #10: Create API Module',
      'subtitle': 'Sub Task 8',
      'priority': 'Low',
      'progress': 0,
      'datetime': '08/04/2025 15:34',
    },
    {
      'title': 'UI Design: Home Page',
      'subtitle': 'Sub Task 2',
      'priority': 'Medium',
      'progress': 40,
      'datetime': '10/04/2025 14:00',
    },
  ].obs;

  final RxString searchQuery = ''.obs;

  List<Map<String, dynamic>> get filteredTasks {
    if (searchQuery.value.isEmpty) return tasks;
    return tasks
        .where((task) =>
            task['title']!.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            task['subtitle']!.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }
}
