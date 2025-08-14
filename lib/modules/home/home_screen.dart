import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/modules/home/home_controller.dart';
import 'package:work_manager/modules/home/widgets/home_bottom.dart';
import '../my_leave/my_leave_screen.dart';
import '../my_task/my_task_screen.dart';
import '../setting/setting_screen.dart';
import 'home_main_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.currentTab,
            children: [
              const HomeMainScreen(),    // Tab 0
               MyTaskScreen(), // Tab 1
              LeaveScreen(),    // Tab 2
              const SettingScreen(),     // Tab 3
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
