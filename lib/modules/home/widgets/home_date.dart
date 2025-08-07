import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:work_manager/shared/constants/colors.dart';

import '../../../shared/controller/locate_controller.dart';

class HomeDate extends StatelessWidget {
  const HomeDate({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();

    return Obx(() {
      final now = DateTime.now();
      final locale = localeController.locale.value.languageCode;
      final weekday = DateFormat.EEEE(locale).format(now);
      final formatted = DateFormat('dd/MM/yyyy').format(now);

      return Text(
        "$weekday, $formatted",
        style: const TextStyle(
          color:ColorConstants.highlightPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    });
  }
}
