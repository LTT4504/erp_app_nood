import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/shared/constants/colors.dart';
import '../../../lang/app_language_key.dart';
import '../model/leave_model.dart';
import '../my_leave_controller.dart';

class AddLeaveDialog extends StatefulWidget {
  const AddLeaveDialog({super.key});
  @override
  State<AddLeaveDialog> createState() => _AddLeaveDialogState();
}

class _AddLeaveDialogState extends State<AddLeaveDialog> {
  final titleController = TextEditingController();
  final reasonController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  String selectedStatus = AppLanguageKey.newLeave;
  final LeaveController controller = Get.find<LeaveController>();

  final List<String> statuses = [
    AppLanguageKey.newLeave,
    AppLanguageKey.waiting,
    AppLanguageKey.approved,
    AppLanguageKey.refuse,
  ];

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2100), locale: Get.locale);
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
          if (endDate == null || endDate!.isBefore(picked)) endDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLanguageKey.addLeaveApplication.tr),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: AppLanguageKey.title.tr)),
            TextField(controller: reasonController, decoration: InputDecoration(labelText: AppLanguageKey.reason.tr)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              items: statuses.map((s) => DropdownMenuItem(value: s, child: Text(s.tr))).toList(),
              onChanged: (v) => setState(() => selectedStatus = v!),
              decoration: InputDecoration(labelText: AppLanguageKey.status.tr),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _pickDate(context, true),
                    child: Text(startDate == null ? AppLanguageKey.chooseAStartDate.tr : '${startDate!.day}/${startDate!.month}/${startDate!.year}'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _pickDate(context, false),
                    child: Text(endDate == null ? AppLanguageKey.chooseAnEndDate.tr : '${endDate!.day}/${endDate!.month}/${endDate!.year}'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text(AppLanguageKey.cancel.tr)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.green),
          onPressed: () {
            if (titleController.text.isNotEmpty && startDate != null && endDate != null) {
              final leave = LeaveModel(
                title: titleController.text,
                date: '${startDate!.day}/${startDate!.month}/${startDate!.year} - ${endDate!.day}/${endDate!.month}/${endDate!.year}',
                status: selectedStatus,
                statusColor: controller.getStatusColor(selectedStatus).value,
                reason: reasonController.text,
                days: '${endDate!.difference(startDate!).inDays + 1} ${AppLanguageKey.days.tr}',
              );
              controller.addLeave(leave);
              Get.back();
            } else {
              Get.snackbar(AppLanguageKey.missingInfo.tr, AppLanguageKey.pleaseFillAll.tr);
            }
          },
          child: Text(AppLanguageKey.save.tr, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
