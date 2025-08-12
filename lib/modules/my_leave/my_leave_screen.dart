import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/shared/constants/colors.dart';
import '../../lang/app_language_key.dart';
import 'my_leave_controller.dart';
import 'widgets/leave_card.dart';
import 'widgets/stat_card.dart';
import 'widgets/leave_form.dart'; // Form mới

class LeaveScreen extends StatelessWidget {
  LeaveScreen({super.key});
  final LeaveController controller = Get.put(LeaveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        backgroundColor: ColorConstants.highlightPrimary,
        title: Text(AppLanguageKey.myLeave.tr, style: const TextStyle(color: ColorConstants.white)),
        centerTitle: true,
        actions: [_languageSwitchButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildStatGrid(),
            const SizedBox(height: 16),
            Text(
              AppLanguageKey.recentLeaveApplications.tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(() => Column(
                  children: controller.leaveRequests.asMap().entries.map((e) {
                    final idx = e.key;
                    final leave = e.value;
                    return GestureDetector(
                      onTap: () => Get.to(() => LeaveForm(leave: leave, index: idx)),
                      child: LeaveCard(
                        leave: leave,
                        statusColor: controller.getStatusColor(leave.status),
                      ),
                    );
                  }).toList(),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.green,
        onPressed: () => Get.to(() => const LeaveForm()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar() => Row(children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: AppLanguageKey.search.tr,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.format_list_bulleted),
        ),
      ]);

  Widget _buildStatGrid() => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: [
          StatCard(AppLanguageKey.annualLeave.tr, "12", Icons.calendar_today, ColorConstants.green),
          StatCard(AppLanguageKey.usedLeaveDays.tr, "3", Icons.check_circle, ColorConstants.green),
          StatCard(AppLanguageKey.leaveWithoutPay.tr, "4", Icons.warning, ColorConstants.green),
          StatCard(AppLanguageKey.remainingLeaveDays.tr, "9", Icons.hourglass_bottom, ColorConstants.green),
        ],
      );

  Widget _languageSwitchButton() => PopupMenuButton<Locale>(
        icon: const Icon(Icons.language, color: Colors.white),
        onSelected: (locale) => Get.updateLocale(locale),
        itemBuilder: (_) => const [
          PopupMenuItem(value: Locale('en', 'US'), child: Text('English 🇺🇸')),
          PopupMenuItem(value: Locale('vi', 'VN'), child: Text('Tiếng Việt 🇻🇳')),
        ],
      );
}
