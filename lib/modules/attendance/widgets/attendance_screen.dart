import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../shared/widgets/attendance_card.dart';
import '../../../shared/widgets/custom_button.dart';
import 'attendance_controller.dart';

class AttendanceScreen extends GetView<AttendanceController> {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chấm công')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final status = controller.status.value;
        final isCheckedIn = status?.checkIn == true;
        final lastCheckIn = _formatTime(status?.checkInDateTime);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Trạng thái hiện tại:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                status != null
                    ? (isCheckedIn
                        ? 'Đã Check In lúc $lastCheckIn'
                        : 'Chưa Check In')
                    : 'Không có dữ liệu',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              if (status == null)
                const SizedBox.shrink()
              else if (status.canCheckIn)
                CustomButton(
                  label: 'Check In',
                  icon: Icons.login,
                  onPressed: () async {
                    await controller.checkIn();
                  },
                )
              else if (status.canCheckOut)
                CustomButton(
                  label: 'Check Out',
                  icon: Icons.logout,
                  backgroundColor: Colors.redAccent,
                  onPressed: () async {
                    await controller.checkOut();
                  },
                )
              else
                CustomButton(
                  label: 'Đã Check Out',
                  icon: Icons.check_circle,
                  backgroundColor: Colors.grey,
                  onPressed: () {},
                  enabled: false,
                ),

              const SizedBox(height: 32),
              const Text('Lịch sử 7 ngày gần đây:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              if (controller.history.isEmpty)
                const Text('Không có dữ liệu lịch sử.')
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.history.length,
                  itemBuilder: (_, index) {
                    final item = controller.history[index];
                    return AttendanceCard(
                      date: item.workDay ?? '-',
                      checkIn: item.checkInOn,
                      checkOut: item.checkOutOn,
                    );
                  },
                ),
            ],
          ),
        );
      }),
    );
  }

  String _formatTime(String? time) {
    if (time == null) return '-';
    try {
      final dateTime = DateTime.parse(time);
      return DateFormat('HH:mm').format(dateTime);
    } catch (_) {
      return time;
    }
  }
}
