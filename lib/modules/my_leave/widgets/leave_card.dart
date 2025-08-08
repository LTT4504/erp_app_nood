import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/shared/constants/colors.dart';
import '../model/leave_model.dart';

class LeaveCard extends StatelessWidget {
  final LeaveModel leave;
  final Color statusColor;

  const LeaveCard({super.key, required this.leave, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(leave.title.tr, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: Text(leave.status.tr, style: TextStyle(color: statusColor, fontWeight: FontWeight.w500, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(leave.date, style: const TextStyle(color: ColorConstants.black, fontSize: 12)),
            if (leave.reason.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(leave.reason.tr, style: const TextStyle(color: ColorConstants.black, fontSize: 12)),
            ],
            const SizedBox(height: 4),
            Text(leave.days, style: const TextStyle(color: Colors.green, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
