// lib/task_detail/description_detail/description_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/lang/app_language_key.dart';
import '../widgets/input_with_card.dart';
import 'description_controller.dart';

class DescriptionScreen extends GetView<DescriptionController> {
  const DescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InputWithCard(
        hintText: AppLanguageKey.enterADescription.tr,
        onSubmit: controller.updateDescription,
        children: controller.description.value.isEmpty
            ? []
            : [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(controller.description.value),
                  ),
                ),
              ],
      );
    });
  }
}
