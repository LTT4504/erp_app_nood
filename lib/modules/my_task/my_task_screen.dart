import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_task_controller.dart';
import '../../shared/constants/colors.dart';
import 'task_card.dart';
import '../task_detail/task_detail_binding.dart';
import '../task_detail/task_detail_screen.dart';

class MyTaskScreen extends GetView<MyTaskController> {
  const MyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyTaskController());
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        backgroundColor: ColorConstants.highlightPrimary,
        elevation: 0,
        title: const Text('My Task', style: TextStyle(color: ColorConstants.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm công việc...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) => controller.search(value),
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
