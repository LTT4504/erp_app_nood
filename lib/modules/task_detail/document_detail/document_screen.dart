// lib/task_detail/document_detail/document_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/lang/app_language_key.dart';
import '../widgets/input_with_card.dart';
import 'document_controller.dart';

class DocumentScreen extends GetView<DocumentController> {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InputWithCard(
        hintText: AppLanguageKey.addDocument.tr,
        onSubmit: controller.addDocument,
        children: controller.documents
            .map((doc) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.insert_drive_file,
                        color: Colors.blue),
                    title: Text(doc),
                  ),
                ))
            .toList(),
      );
    });
  }
}
