import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/constants/colors.dart';
import 'task_controller.dart';

class TaskScreen extends GetView<TaskController> {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔍 Search Field
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search tasks...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              controller.searchQuery.value = value;
            },
          ),
        ),

        // 📋 Task List
        Expanded(
          child: Obx(() {
            final tasks = controller.filteredTasks;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskCard(task: task);
              },
            );
          }),
        ),
      ],
    );
  }
}

class TaskCard extends StatelessWidget {
  final Map<String, dynamic> task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task['title'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'To do',
                  style: TextStyle(color: Colors.orange, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            task['subtitle'] ?? '',
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 12),

          // Priority & Progress
          Row(
            children: [
              const Icon(Icons.priority_high, color: Colors.blue, size: 16),
              const SizedBox(width: 4),
              Text(
                task['priority'] ?? 'Low',
                style: const TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress Bar
          Row(
            children: [
              const Icon(Icons.access_time, size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: LinearProgressIndicator(
                  value: ((task['progress'] ?? 0) / 100).clamp(0.0, 1.0),
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.blue,
                  minHeight: 8,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "${task['progress'] ?? 0}%",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.person_outline),
              Text(
                task['datetime'] ?? '',
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
