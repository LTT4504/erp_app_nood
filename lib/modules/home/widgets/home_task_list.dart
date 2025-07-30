import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home.dart';
import 'home_section.dart';

class HomeTaskList extends GetView<HomeController> {
  const HomeTaskList({super.key});

  Color _priorityColor(String level) {
    switch (level) {
      case 'Cao': return Colors.red;
      case 'Trung bình': return Colors.orange;
      case 'Thấp': return Colors.grey.shade400;
      default: return Colors.grey;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Cần làm': return Colors.red;
      case 'Trong tiến trình': return Colors.orange.shade200;
      case 'Đang review': return Colors.blue;
      default: return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tasks = controller.tasks;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: "Today's Work",
            actionText: "Tất cả (${tasks.length})",
            onAction: () {},
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
            ),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, index) {
                final task = tasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _priorityColor(task.priority),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(task.priority, style: const TextStyle(fontSize: 12)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(task.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                            Text(task.project, style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _statusColor(task.status),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(task.status, style: const TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
