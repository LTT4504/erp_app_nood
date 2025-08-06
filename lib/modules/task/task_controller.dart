import 'package:get/get.dart';

import 'model/task_model.dart';

class TaskController extends GetxController {
  final tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    tasks.assignAll([
      Task(
          priority: 'high',
          title: 'task_bg_wrong',
          project: 'project_a',
          status: 'to_do'),
      Task(
          priority: 'medium',
          title: 'task_sync_error',
          project: 'project_b',
          status: 'in_progress'),
      Task(
          priority: 'medium',
          title: 'task_update_time',
          project: 'project_c',
          status: 'to_do'),
      Task(
          priority: 'easy',
          title: 'task_add_japanese',
          project: 'project_d',
          status: 'reviewing'),
      Task(
          priority: 'easy',
          title: 'task_wrong_icon',
          project: 'project_d',
          status: 'in_progress'),
    ]);
  }
}
