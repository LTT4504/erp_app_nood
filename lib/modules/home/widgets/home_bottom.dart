import 'package:flutter/material.dart';
import 'package:work_manager/shared/constants/colors.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: ColorConstants.highlightPrimary,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.event_note), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.task), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
      ],
    );
  }
}
