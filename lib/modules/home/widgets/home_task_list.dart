import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../task/task_controller.dart';
import '../../../lang/app_language_key.dart';

class HomeTaskList extends GetView<TaskController> {
  const HomeTaskList({super.key});

  Color _priorityColor(String level) {
    if (level == 'High' || level == 'Cao' || level == AppLanguageKey.high.tr) {
      return Colors.red;
    } else if (level == 'Medium' ||
        level == 'Trung bình' ||
        level == AppLanguageKey.medium.tr) {
      return Colors.orange;
    } else if (level == 'Easy' ||
        level == 'Dễ' ||
        level == AppLanguageKey.easy.tr) {
      return Colors.grey.shade400;
    } else {
      return Colors.grey;
    }
  }

  Color _statusColor(String status) {
    if (status == 'To Do' ||
        status == 'Chưa làm' ||
        status == AppLanguageKey.toDo.tr) {
      return Colors.red;
    } else if (status == 'In Progress' ||
        status == 'Đang tiến hành' ||
        status == AppLanguageKey.inProgress.tr) {
      return Colors.orange.shade200;
    } else if (status == 'Reviewing' ||
        status == 'Đang xem xét' ||
        status == AppLanguageKey.reviewing.tr) {
      return Colors.blue;
    } else {
      return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tasks = controller.tasks;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with action
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  AppLanguageKey.todaysTasks,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${AppLanguageKey.all} (${tasks.length})',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Task List
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      // Priority label
                      Container(
                        constraints:
                            const BoxConstraints(minWidth: 60, minHeight: 28),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _priorityColor(task.priority),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          task.priority.tr, // ✅ translate priority
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Title and Project
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              task.title.tr,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              task.project.tr,
                              style: const TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Status label
                      Container(
                        constraints:
                            const BoxConstraints(minWidth: 80, minHeight: 28),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _statusColor(task.status),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          task.status.tr, // ✅ translate status
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
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
