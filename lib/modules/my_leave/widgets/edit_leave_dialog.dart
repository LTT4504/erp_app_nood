import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/shared/constants/colors.dart';
import '../../../lang/app_language_key.dart';
import '../model/leave_model.dart';
import '../my_leave_controller.dart';

class EditLeaveDialog extends StatefulWidget {
  final int index;
  final LeaveModel leave;
  const EditLeaveDialog({super.key, required this.index, required this.leave});
  @override
  State<EditLeaveDialog> createState() => _EditLeaveDialogState();
}

class _EditLeaveDialogState extends State<EditLeaveDialog> {
  late TextEditingController titleController, reasonController;
  late DateTime startDate, endDate;
  late String selectedStatus;
  final LeaveController controller = Get.find<LeaveController>();
  final statuses = [AppLanguageKey.newLeave, AppLanguageKey.waiting, AppLanguageKey.approved, AppLanguageKey.refuse];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.leave.title);
    reasonController = TextEditingController(text: widget.leave.reason);
    selectedStatus = statuses.contains(widget.leave.status) ? widget.leave.status : statuses.first;
    final parts = widget.leave.date.split(' - ');
    startDate = _parseDate(parts[0]);
    endDate = _parseDate(parts[1]);
  }

  DateTime _parseDate(String text) {
    final p = text.split('/');
    return DateTime(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]));
  }

  Future<void> _pickDate(BuildContext c, bool isStart) async {
    final picked = await showDatePicker(
      context: c, initialDate: isStart ? startDate : endDate, firstDate: DateTime(2020), lastDate: DateTime(2100), locale: Get.locale);
    if (picked != null) {
      setState(() {
        if (isStart) { startDate = picked; if (endDate.isBefore(picked)) endDate = picked; } else { endDate = picked; }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLanguageKey.editLeaveApplication.tr),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: AppLanguageKey.title.tr)),
            TextField(controller: reasonController, decoration: InputDecoration(labelText: AppLanguageKey.reason.tr)),
            const SizedBox(height: 8),
            DropdownButtonFormField(
              value: selectedStatus,
              items: statuses.map((s) => DropdownMenuItem(value: s, child: Text(s.tr))).toList(),
              onChanged: (v) => setState(() => selectedStatus = v!),
              decoration: InputDecoration(labelText: AppLanguageKey.status.tr),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: () => _pickDate(context, true), child: Text('${startDate.day}/${startDate.month}/${startDate.year}'))),
                const SizedBox(width: 8),
                Expanded(child: ElevatedButton(onPressed: () => _pickDate(context, false), child: Text('${endDate.day}/${endDate.month}/${endDate.year}'))),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () { controller.deleteLeave(widget.index); Get.back(); }, child: Text(AppLanguageKey.erase.tr, style: const TextStyle(color: Colors.red))),
        TextButton(onPressed: () => Get.back(), child: Text(AppLanguageKey.cancel.tr)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.green),
          onPressed: () {
            final updated = LeaveModel(
              title: titleController.text,
              date: '${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}',
              status: selectedStatus,
              statusColor: controller.getStatusColor(selectedStatus).value,
              reason: reasonController.text,
              days: '${endDate.difference(startDate).inDays + 1} ${AppLanguageKey.days.tr}',
            );
            controller.updateLeave(widget.index, updated);
            Get.back();
          },
          child: Text(AppLanguageKey.save.tr, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
