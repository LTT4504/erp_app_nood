import 'package:get/get.dart';

class ProjectController extends GetxController {
  var projects = [
    {"name": "TrueCoop", "type": "Product"},
    {"name": "Borderless Business Lab", "type": "Product"},
    {"name": "ERP 2025", "type": "Product"},
  ].obs;

  var filteredProjects = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredProjects.assignAll(projects);
  }

  void filterProjects(String keyword) {
    if (keyword.isEmpty) {
      filteredProjects.assignAll(projects);
    } else {
      filteredProjects.assignAll(
        projects
            .where((p) =>
                p['name']!.toLowerCase().contains(keyword.toLowerCase()))
            .toList(),
      );
    }
  }
}
