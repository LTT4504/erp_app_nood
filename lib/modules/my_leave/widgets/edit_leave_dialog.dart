import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../my_leave_controller.dart';
import 'package:work_manager/shared/constants/colors.dart';

class EditLeaveDialog extends StatefulWidget {
  final int index;
  final Map<String, dynamic> leave;

  const EditLeaveDialog({super.key, required this.index, required this.leave});

  @override
  State<EditLeaveDialog> createState() => _EditLeaveDialogState();
}

class _EditLeaveDialogState extends State<EditLeaveDialog> {
  late TextEditingController titleController;
  late TextEditingController reasonController;
  late DateTime startDate;
  late DateTime endDate;
  late String selectedStatus;

  final LeaveController controller = Get.find<LeaveController>();
  final List<String> statuses = ["Mới", "Đang duyệt", "Đã duyệt", "Từ chối"];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.leave["title"]);
    reasonController = TextEditingController(text: widget.leave["reason"]);

    // Bảo đảm selectedStatus nằm trong danh sách statuses, nếu không đặt mặc định là phần tử đầu
    String statusFromData = widget.leave["status"];
    if (statuses.contains(statusFromData)) {
      selectedStatus = statusFromData;
    } else {
      selectedStatus = statuses.first;
    }

    List<String> dates = widget.leave["date"].split(" - ");
    startDate = _parseDate(dates[0]);
    endDate = _parseDate(dates[1]);
  }

  DateTime _parseDate(String date) {
    List<String> parts = date.split("/");
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale('vi', 'VN'),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
          if (endDate.isBefore(picked)) {
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
      title: const Text("Chỉnh sửa đơn nghỉ phép"),
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
              value: statuses.contains(selectedStatus) ? selectedStatus : null,
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
                      "${startDate.day}/${startDate.month}/${startDate.year}",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _pickDate(context, false),
                    child: Text(
                      "${endDate.day}/${endDate.month}/${endDate.year}",
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
          onPressed: () {
            controller.deleteLeave(widget.index);
            Navigator.pop(context);
          },
          child: const Text("Xóa", style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Hủy"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.green,
          ),
          onPressed: () {
            controller.updateLeave(widget.index, {
              "title": titleController.text,
              "date":
                  "${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}",
              "status": selectedStatus,
              "statusColor": controller.getStatusColor(selectedStatus),
              "reason": reasonController.text,
              "days": "${endDate.difference(startDate).inDays + 1} ngày",
            });
            Navigator.pop(context);
          },
          child: const Text("Lưu", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
