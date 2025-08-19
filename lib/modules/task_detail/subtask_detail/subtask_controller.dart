import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SubTaskController extends GetxController {
  final box = GetStorage();
  final subTasks = <Map<String, dynamic>>[].obs;

  final String storageKey = "subTasks";

  @override
  void onInit() {
    super.onInit();
    // Load từ local
    List? stored = box.read(storageKey);
    if (stored != null) {
      subTasks.assignAll(List<Map<String, dynamic>>.from(stored));
    }
  }

  void addSubTask(String title) {
    final newTask = {"title": title, "done": false};
    subTasks.add(newTask);
    _saveToStorage();
  }

  void toggleSubTask(int index) {
    subTasks[index]["done"] = !(subTasks[index]["done"] as bool);
    subTasks.refresh();
    _saveToStorage();
  }

  void _saveToStorage() {
    box.write(storageKey, subTasks);
  }
}
