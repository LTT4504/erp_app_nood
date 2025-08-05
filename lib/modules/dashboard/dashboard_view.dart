// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:work_manager/modules/home/home.dart';
// import 'package:work_manager/modules/home/home_menu_tab.dart';
// import 'dashboard_controller.dart';

// class DashboardView extends GetView<DashboardController> {
//   const DashboardView({super.key});

//   final List<Widget> _screens = const [
//     HomeScreen(),
//     // CalendarView(),
//     // TaskView(),
//     // HomeMenuTab(),
//   ];

//   // final List<BottomNavigationBarItem> _items = const [
//   //   BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//   //   BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
//   //   BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
//   //   BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Settings'),
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final index = controller.currentIndex.value;
//       return Scaffold(
//         body: _screens[index],
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: index,
//           onTap: controller.changeTab,
//           items: _items,
//           selectedItemColor: Colors.green,
//           unselectedItemColor: Colors.grey,
//           type: BottomNavigationBarType.fixed,
//         ),
//       );
//     });
//   }
// }
