import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/lang/app_language_key.dart';

import '../widgets/input_with_card.dart';
import 'subtask_controller.dart';

class SubTaskScreen extends GetView<SubTaskController> {
  const SubTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InputWithCard(
        hintText: AppLanguageKey.addSubTask.tr,
        onSubmit: controller.addSubTask,
        children: controller.subTasks
            .asMap()
            .entries
            .map((entry) {
              final index = entry.key;
              final subTask = entry.value;
              final done = subTask["done"] as bool;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: CheckboxListTile(
                  value: done,
                  title: Text(
                    subTask["title"],
                    style: TextStyle(
                      fontSize: 16,
                      decoration: done
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: done ? Colors.grey : Colors.black,
                    ),
                  ),
                  onChanged: (_) => controller.toggleSubTask(index),
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              );
            })
            .toList(),
      );
    });
  }
}
