import 'package:flutter/material.dart';
import 'package:work_manager/modules/home/widgets/home_app_bar.dart';
import 'package:work_manager/modules/home/widgets/home_date.dart';
import 'package:work_manager/modules/home/widgets/home_menu_grid.dart';
import 'package:work_manager/modules/task/task_list.dart';
import 'package:work_manager/shared/constants/colors.dart';

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.highlightPrimaryPastel, 
      child: const Column(
        children: [
          HomeAppBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(height: 12),
                  HomeDate(),
                  SizedBox(height: 24),
                  HomeMenuGrid(),
                  SizedBox(height: 24),
                  TaskList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
