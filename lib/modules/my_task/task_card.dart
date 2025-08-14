import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/lang/app_language_key.dart';
import '../../../shared/constants/colors.dart';

class TaskCard extends StatelessWidget {
  final Map<String, dynamic> task;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        color: ColorConstants.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề + trạng thái
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
                    child: Text(
                      AppLanguageKey.toDo.tr,
                      style: const TextStyle(color: Colors.orange, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Project / Subtitle
              Text(
                task['project'] ?? task['subtitle'] ?? '',
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 8),

              // Priority
              Row(
                children: [
                  const Icon(Icons.priority_high, color: Colors.blue, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    task['priority'] ?? AppLanguageKey.low.tr,
                    style: const TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Progress
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: ((task['progress'] as num? ?? 0) / 100).clamp(0.0, 1.0),
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

              // Người phụ trách + Thời gian
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.person_outline),
                  Text(
                    task['datetime'] ?? '',
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
