import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/widgets/attendance_card.dart';
import '../../../shared/widgets/custom_button.dart';
import 'attendance_controller.dart';

class AttendanceScreen extends GetView<AttendanceController> {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: ColorConstants.highlightPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final status = controller.status.value;
       

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Colors.white,
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Status',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      const SizedBox(height: 12),
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
                          label: 'Checked Out',
                          icon: Icons.check_circle,
                          backgroundColor:  Colors.redAccent,
                          onPressed: () {},
                          enabled: false,
                        ),
                        
                    ],
                  ),
                ),
              ),

              const Text(
                'Recent History (Last 7 Days)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              if (controller.history.isEmpty)
                const Text('No attendance history found.')
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

}
