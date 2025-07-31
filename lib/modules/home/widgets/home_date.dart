import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_manager/shared/constants/colors.dart';

class HomeDate extends StatefulWidget {
  const HomeDate({super.key});

  @override
  State<HomeDate> createState() => _HomeDateState();
}

class _HomeDateState extends State<HomeDate> {
  String _formattedDate = '';

  @override
  void initState() {
    super.initState();
    _updateDate();
  }

  void _updateDate() {
    final now = DateTime.now();
    final weekday = _weekdayVietnamese(now.weekday);
    final formatted = DateFormat('dd/MM/yyyy').format(now);
    setState(() {
      _formattedDate = "$weekday, $formatted";
    });
  }

  String _weekdayVietnamese(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tueday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Saturday';
      case 6:
        return 'Friday';
      case 7:
      default:
        return 'Sunday';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formattedDate,
      style: const TextStyle(
        color: ColorConstants.highlightPrimary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
