import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';

class EditFAB extends StatelessWidget {
  final RxBool isEditing;
  final VoidCallback onEdit;

  const EditFAB({
    super.key,
    required this.isEditing,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // chỉ hiện khi không trong chế độ edit
      if (isEditing.value) return const SizedBox.shrink();
      return FloatingActionButton(
        backgroundColor: ColorConstants.highlightPrimary,
        onPressed: onEdit,
        child: const Icon(Icons.edit, color: Colors.white),
      );
    });
  }
}
