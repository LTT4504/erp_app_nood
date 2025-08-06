import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/widgets/attendance_card.dart';
import '../../shared/widgets/date_range_picker.dart'; // đã import

import 'widgets/attendance_controller.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() => _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  DateTime? fromDate;
  DateTime? toDate;

  final AttendanceController controller = Get.find();

  List get filteredHistory => controller.history;

  Future<void> _fetchHistoryByDate() async {
    if (fromDate != null && toDate != null) {
      await controller.fetchHistoryByRange(fromDate!, toDate!);
    }
  }

  void _onPickDate(bool isFrom, DateTime picked) async {
    setState(() {
      if (isFrom) {
        fromDate = picked;
        if (toDate != null && picked.isAfter(toDate!)) {
          toDate = picked;
        }
      } else {
        toDate = picked;
        if (fromDate != null && picked.isBefore(fromDate!)) {
          fromDate = picked;
        }
      }
    });
    await _fetchHistoryByDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        title: const Text('Attendance History'),
        backgroundColor: ColorConstants.highlightPrimary,
        foregroundColor: ColorConstants.white,
        elevation: 0,
      ),
      body: Obx(() {
        return Column(
          children: [
            DateRangePicker(
              fromDate: fromDate,
              toDate: toDate,
              onShowPicker: defaultShowDatePicker, 
              onPickDate: _onPickDate,
            ),
            Expanded(
              child: filteredHistory.isEmpty
                  ? const Center(child: Text('No attendance records found.'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredHistory.length,
                      itemBuilder: (_, index) {
                        final item = filteredHistory[index];
                        return AttendanceCard(
                          date: item.workDay ?? '-',
                          checkIn: item.checkInOn,
                          checkOut: item.checkOutOn,
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}
