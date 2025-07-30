import 'package:get/get.dart';
import 'models/home_task.dart';

class HomeController extends GetxController {
  final tasks = <HomeTask>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    tasks.assignAll([
      HomeTask(priority: "Cao", title: "Sai màu background", project: "Project A", status: "Cần làm"),
      HomeTask(priority: "Trung bình", title: "Lỗi đồng bộ dữ liệu", project: "Project B", status: "Trong tiến trình"),
      HomeTask(priority: "Trung bình", title: "Update date time", project: "Project C", status: "Cần làm"),
      HomeTask(priority: "Thấp", title: "Thêm ngôn ngữ nhật", project: "Project D", status: "Đang review"),
      HomeTask(priority: "Thấp", title: "Sai icon", project: "Project D", status: "Trong tiến trình"),
    ]);
  }
}
