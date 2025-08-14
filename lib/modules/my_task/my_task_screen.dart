import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/lang/app_language_key.dart';
import 'my_task_controller.dart';
import '../../shared/constants/colors.dart';
import 'task_card.dart';
import '../task_detail/task_detail_binding.dart';
import '../task_detail/task_detail_screen.dart';

class MyTaskScreen extends StatelessWidget {
  MyTaskScreen({super.key});

  // Đảm bảo controller luôn được khởi tạo
  final MyTaskController controller = Get.put(MyTaskController());

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        backgroundColor: ColorConstants.highlightPrimary,
        elevation: 0,
        title: Text(
          AppLanguageKey.myTasks.tr,
          style: const TextStyle(color: ColorConstants.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppLanguageKey.searchForJobs.tr,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: controller.search,
            ),
          ),
          Expanded(
            child: Obx(() {
              final tasks = controller.filteredTasks;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskCard(
                    task: task,
                    onTap: () {
                      Get.to(
                        () => const TaskDetailScreen(),
                        binding: TaskDetailBinding(),
                        arguments: task,
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
