import 'package:flutter/material.dart';
import 'package:work_manager/shared/constants/colors.dart';
import '../../../lang/app_language_key.dart';
import 'package:get/get.dart';
import 'stat_card.dart';

class StatGrid extends StatelessWidget {
  const StatGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: [
        StatCard(AppLanguageKey.annualLeave.tr, "12", Icons.calendar_today,
            ColorConstants.green),
        StatCard(AppLanguageKey.usedLeaveDays.tr, "3", Icons.check_circle,
            ColorConstants.green),
        StatCard(AppLanguageKey.leaveWithoutPay.tr, "4", Icons.warning,
            ColorConstants.green),
        StatCard(AppLanguageKey.remainingLeaveDays.tr, "9",
            Icons.hourglass_bottom, ColorConstants.green),
      ],
    );
  }
}
