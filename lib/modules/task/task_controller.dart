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
      Task(priority: "High", title: "Sai màu background", project: "Project A", status: "To Do"),
      Task(priority: "Medium", title: "Lỗi đồng bộ dữ liệu", project: "Project B", status: "In Progress"),
      Task(priority: "Medium", title: "Update date time", project: "Project C", status: "To Do"),
      Task(priority: "Easy", title: "Thêm ngôn ngữ nhật", project: "Project D", status: "Reviewing"),
      Task(priority: "Easy", title: "Sai icon", project: "Project D", status: "In Progress"),
    ]);
  }
}
