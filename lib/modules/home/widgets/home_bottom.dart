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

  Widget _buildIcon(IconData icon, bool isActive, double iconSize) {
    return Container(
      padding: EdgeInsets.all(iconSize * 0.23),
      child: Icon(
        icon,
        size: iconSize,
        color: isActive ? ColorConstants.highlightPrimary : ColorConstants.darkGray,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final height = mq.size.height;
    final navHeight = (height * 0.11).clamp(60.0, 90.0); 
    final iconSize = (width * 0.08).clamp(26.0, 35.0); 
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(width * 0.05),
      topRight: Radius.circular(width * 0.05),
    );
    return Container(
      height: navHeight,
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
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
            icon: _buildIcon(Icons.home_rounded, currentIndex == 0, iconSize),
            label: '',
          ),
          // BottomNavigationBarItem(
          //   icon: _buildIcon(Icons.event_note_rounded, currentIndex == 1),
          //   label: '',
          // ),
          // BottomNavigationBarItem(
          //   icon: _buildIcon(Icons.task_rounded, currentIndex == 2),
          //   label: '',
          // ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.menu_rounded, currentIndex == 3, iconSize),
            label: '',
          ),
        ],
      ),
    );
  }
}
