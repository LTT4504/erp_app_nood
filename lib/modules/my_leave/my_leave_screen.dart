import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/shared/constants/colors.dart';
import 'my_leave_controller.dart';
import 'widgets/leave_card.dart';
import 'widgets/add_leave_dialog.dart';
import 'widgets/edit_leave_dialog.dart';
import 'widgets/stat_card.dart';

class LeaveScreen extends StatelessWidget {
  LeaveScreen({super.key});

  final LeaveController controller = Get.put(LeaveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        backgroundColor: ColorConstants.highlightPrimary,
        title: const Text("Nghỉ phép của tôi", style: TextStyle(color: ColorConstants.white),),
        centerTitle: true,
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
            const Text(
              "Đơn nghỉ phép gần đây",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(() => Column(
              children: controller.leaveRequests.asMap().entries.map((entry) {
                int index = entry.key;
                var item = entry.value;
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => EditLeaveDialog(
                        index: index,
                        leave: item,
                      ),
                    );
                  },
                  child: LeaveCard(
                    title: item["title"],
                    date: item["date"],
                    status: item["status"],
                    statusColor: controller.getStatusColor(item["status"]),
                    reason: item["reason"],
                    days: item["days"],
                  ),
                );
              }).toList(),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.green,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddLeaveDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Tìm kiếm...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.format_list_bulleted),
        )
      ],
    );
  }

  Widget _buildStatGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: const [
        StatCard("Nghỉ phép thường niên", "12", Icons.calendar_today, ColorConstants.green),
        StatCard("Ngày nghỉ phép đã dùng", "3", Icons.check_circle, ColorConstants.green),
        StatCard("Nghỉ không lương", "4", Icons.warning, ColorConstants.green),
        StatCard("Ngày nghỉ phép còn lại", "9", Icons.hourglass_bottom, ColorConstants.green),
      ],
    );
  }
}
