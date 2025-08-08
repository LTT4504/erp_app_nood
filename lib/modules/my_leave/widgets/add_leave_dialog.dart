import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../my_leave_controller.dart';
import 'package:work_manager/shared/constants/colors.dart';

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
  String selectedStatus = "Mới";

  final LeaveController controller = Get.find<LeaveController>();

  final List<String> statuses = ["Mới", "Đang duyệt", "Đã duyệt", "Từ chối"];

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale('vi', 'VN'),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
          if (endDate == null || endDate!.isBefore(picked)) {
            endDate = picked;
          }
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Thêm đơn nghỉ phép"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Tiêu đề"),
            ),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(labelText: "Lý do"),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              items: statuses.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                });
              },
              decoration: const InputDecoration(labelText: "Trạng thái"),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _pickDate(context, true),
                    child: Text(
                      startDate == null
                          ? "Chọn ngày bắt đầu"
                          : "${startDate!.day}/${startDate!.month}/${startDate!.year}",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _pickDate(context, false),
                    child: Text(
                      endDate == null
                          ? "Chọn ngày kết thúc"
                          : "${endDate!.day}/${endDate!.month}/${endDate!.year}",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Hủy"),
        ),
        ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: ColorConstants.green),
          onPressed: () {
            if (titleController.text.isNotEmpty &&
                startDate != null &&
                endDate != null) {
              controller.addLeave({
                "title": titleController.text,
                "date":
                    "${startDate!.day}/${startDate!.month}/${startDate!.year} - ${endDate!.day}/${endDate!.month}/${endDate!.year}",
                "status": selectedStatus,
                "statusColor": controller.getStatusColor(selectedStatus),
                "reason": reasonController.text,
                "days": "${endDate!.difference(startDate!).inDays + 1} ngày",
              });
              Navigator.pop(context);
            }
          },
          child: const Text("Thêm", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
