import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../annual_calendar_controller.dart';
import '../../../lang/app_language_key.dart';

Future<void> showAddMeetingDialog(
    BuildContext context, AnnualCalendarController controller) async {
  final titleController = TextEditingController();
  final timeController = TextEditingController();
  DateTime? pickedDate = controller.selectedDate.value;

  await showDialog(
    context: context, // dùng context được truyền vào
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('information'.tr), // đa ngôn ngữ
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: AppLanguageKey.titleMeeting.tr),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: timeController,
                    decoration: InputDecoration(labelText: AppLanguageKey.timeMeeting.tr),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          pickedDate == null
                              ? 'No date picked'.tr
                              : pickedDate!.toLocal().toString().split(' ')[0],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: pickedDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) {
                            setState(() {
                              pickedDate = date;
                            });
                          }
                        },
                        child: Text(AppLanguageKey.pickedDate.tr),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(AppLanguageKey.cancel.tr),
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.trim().isEmpty ||
                      timeController.text.trim().isEmpty ||
                      pickedDate == null) {
                    Get.snackbar('Error'.tr, 'Please fill all fields'.tr);
                    return;
                  }

                  controller.addMeeting({
                    "title": titleController.text.trim(),
                    "time": timeController.text.trim(),
                    "date": pickedDate!.toIso8601String(),
                  });

                  controller.selectedDate.value = pickedDate!;
                  Get.back();
                },
                child: Text(AppLanguageKey.save.tr),
              ),
            ],
          );
        },
      );
    },
  );
}
