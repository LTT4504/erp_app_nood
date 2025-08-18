import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../annual_calendar_controller.dart';
import '../../../lang/app_language_key.dart';
import 'package:work_manager/shared/constants/colors.dart';
import '../../../shared/widgets/date_range_picker.dart';

Future<void> showAddMeetingDialog(
    BuildContext context, AnnualCalendarController controller) async {
  final titleController = TextEditingController();
  final timeController = TextEditingController();
  DateTime? pickedDate = controller.selectedDate.value;

  await showDialog(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'information'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: AppLanguageKey.titleMeeting.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: timeController,
                    decoration: InputDecoration(
                      labelText: AppLanguageKey.timeMeeting.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            pickedDate == null
                                ? 'No date picked'.tr
                                : pickedDate!.toLocal().toString().split(' ')[0],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: () async {
                          final date = await defaultShowDatePicker(
                            context,
                            pickedDate,
                            lastDate: DateTime(2100),
                          );
                          if (date != null) {
                            setState(() {
                              pickedDate = date;
                            });
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          side:
                              BorderSide(color: ColorConstants.highlightPrimary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                        ),
                        icon: Icon(Icons.date_range,
                            color: ColorConstants.highlightPrimary),
                        label: Text(
                          AppLanguageKey.pickedDate.tr,
                          style:
                              TextStyle(color: ColorConstants.highlightPrimary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actionsPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  foregroundColor: ColorConstants.highlightPrimary,
                ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.highlightPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text(
                  AppLanguageKey.save.tr,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
