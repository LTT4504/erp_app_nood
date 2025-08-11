import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/lang/app_language_key.dart';
import 'notification_controller.dart';
import '../../shared/constants/colors.dart';

class PersonalNotificationsScreen
    extends GetView<PersonalNotificationsController> {
  const PersonalNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: ColorConstants.highlightPrimary,
        title: Text(AppLanguageKey.personalNotifications.tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _buildTabs(),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              final list = _getCurrentList();
              if (list.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.folder_off, size: 80, color: Colors.grey),
                    const SizedBox(height: 8),
                    Text(AppLanguageKey.noData.tr,
                        style: const TextStyle(color: Colors.grey)),
                  ],
                );
              }
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, i) => ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Text(list[i]),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        color: Colors.green.shade100, // nền cho toàn bộ tab
        child: Row(
          children: [
            _buildTab(AppLanguageKey.leaveIsAllowed.tr, 0),
            _buildTab(AppLanguageKey.calendar.tr, 1),
            _buildTab(AppLanguageKey.shared.tr, 2),
          ],
        ),
      );
    });
  }

  Widget _buildTab(String text, int index) {
    final isSelected = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectedTab.value = index,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? ColorConstants.highlightPrimary : Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 2, // cho phép xuống dòng
            overflow: TextOverflow.ellipsis, // hoặc cắt bớt nếu quá dài
            style: TextStyle(
              fontSize: 13,
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  List<String> _getCurrentList() {
    switch (controller.selectedTab.value) {
      case 0:
        return controller.leaveNotifications;
      case 1:
        return controller.scheduleNotifications;
      default:
        return controller.generalNotifications;
    }
  }
}
