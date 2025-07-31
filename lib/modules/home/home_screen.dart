// home_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/shared/constants/colors.dart';
import '../task/task_list.dart';
import 'home_controller.dart';
import 'home_menu_tab.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_bottom.dart';
import 'widgets/home_date.dart';
import 'widgets/home_menu_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildCurrentTab(int currentTab) {
    switch (currentTab) {
      case 0:
        return ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            SizedBox(height: 12),
            HomeDate(),
            SizedBox(height: 24),
            HomeMenuGrid(),
            SizedBox(height: 24),
            TaskList(),
          ],
        );
      case 1:
        return const Center(child: Text("Event Tab"));
      case 2:
        return const Center(child: Text("Task Tab"));
      case 3:
        return const HomeMenuTab();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorConstants.highlightPrimaryPastel,
          body: Column(
            children: [
              const HomeAppBar(),
              Expanded(child: _buildCurrentTab(controller.currentTab)),
            ],
          ),
          bottomNavigationBar: HomeBottomNav(
            currentIndex: controller.currentTab,
            onTap: controller.changeTab,
          ),
        );
      },
    );
  }
}
