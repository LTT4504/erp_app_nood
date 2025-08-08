import 'package:flutter/material.dart';

class LeaveCard extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final Color statusColor;
  final String reason;
  final String days;

  const LeaveCard({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.reason,
    required this.days,
  });

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
            // Tiêu đề + trạng thái
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            if (reason.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                reason,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
            const SizedBox(height: 4),
            Text(
              days,
              style: const TextStyle(color: Colors.green, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
