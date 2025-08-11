import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:work_manager/shared/constants/colors.dart';
import '../../lang/app_language_key.dart';
import 'annual_calendar_controller.dart';
import 'widgets/add_showdialog.dart';

class AnnualCalendarScreen extends GetView<AnnualCalendarController> {
  const AnnualCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        backgroundColor: ColorConstants.highlightPrimary,
        title: Text(AppLanguageKey.annualCalendarTitle.tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(12),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(() {
                  return TableCalendar(
                    firstDay: DateTime.utc(2000, 1, 1),
                    lastDay: DateTime.utc(2100, 12, 31),
                    focusedDay: controller.selectedDate.value,
                    selectedDayPredicate: (day) =>
                        isSameDay(controller.selectedDate.value, day),
                    onDaySelected: controller.onDateSelected,
                    calendarFormat: CalendarFormat.month,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: ColorConstants.green.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: ColorConstants.highlightPrimary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  const Icon(Icons.access_time_outlined,
                      color: ColorConstants.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppLanguageKey.meetingsSchedule.tr, // sửa key và thêm .tr
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle,
                        size: 28, color: ColorConstants.green),
                    onPressed: () {
                      showAddMeetingDialog(
                          context, controller); // truyền context + controller
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Obx(() {
                final filtered = controller.meetings
                    .where((m) => isSameDay(
                          DateTime.parse(m['date']),
                          controller.selectedDate.value,
                        ))
                    .toList();

                if (filtered.isEmpty) {
                  return Center(child: Text("No meeting found".tr));
                }

                return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    final meeting = filtered[index];
                    final dateStr = DateTime.parse(meeting['date'])
                        .toLocal()
                        .toString()
                        .split(' ')[0];

                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        title: Text(
                          meeting['title'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${meeting['time'] ?? ''} • $dateStr'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: ColorConstants.green),
                          onPressed: () {
                            final globalIndex = controller.meetings.indexWhere(
                                (m) =>
                                    m['title'] == meeting['title'] &&
                                    m['time'] == meeting['time'] &&
                                    m['date'] == meeting['date']);
                            if (globalIndex != -1) {
                              controller.removeMeetingAt(globalIndex);
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
