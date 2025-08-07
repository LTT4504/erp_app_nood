import 'package:get/get.dart';

class MyTaskController extends GetxController {
  final tasks = [
    {'title': 'Thiết kế giao diện', 'project': 'Dự án A'},
    {'title': 'Viết API', 'project': 'Dự án B'},
    {'title': 'Kiểm thử hệ thống', 'project': 'Dự án C'},
  ].obs;

  final filteredTasks = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredTasks.assignAll(tasks);
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredTasks.assignAll(tasks);
    } else {
      filteredTasks.assignAll(tasks.where((task) =>
        task['title']!.toLowerCase().contains(query.toLowerCase())
      ));
    }
  }
}
