import 'package:flutter/material.dart';

import 'widgets/home_app_bar.dart';
import 'widgets/home_bottom.dart';
import 'widgets/home_date.dart';
import 'widgets/home_menu_grid.dart';
import 'widgets/home_task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;

  void _onTabChanged(int index) {
    setState(() => currentTab = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const HomeAppBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                SizedBox(height: 12),
                HomeDate(),
                SizedBox(height: 24),
                HomeMenuGrid(),
                SizedBox(height: 24),
                HomeTaskList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: HomeBottomNav(
        currentIndex: currentTab,
        onTap: _onTabChanged,
      ),
    );
  }
}
