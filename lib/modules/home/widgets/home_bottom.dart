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

  Widget _buildIcon(IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Icon(
        icon,
        size: 35,
        color: isActive ? ColorConstants.highlightPrimary : ColorConstants.darkGray,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: ColorConstants.highlightPrimaryPastel,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        elevation: 0,
        selectedItemColor: ColorConstants.highlightPrimary,
        unselectedItemColor: ColorConstants.darkGray,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home_rounded, currentIndex == 0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.event_note_rounded, currentIndex == 1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.task_rounded, currentIndex == 2),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.menu_rounded, currentIndex == 3),
            label: '',
          ),
        ],
      ),
    );
  }
}
