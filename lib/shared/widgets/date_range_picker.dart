import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../shared/constants/colors.dart';

class DateRangePicker extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final Future<DateTime?> Function(BuildContext context, DateTime? initialDate)
      onShowPicker;
  final Function(bool isFrom, DateTime picked) onPickDate;

  const DateRangePicker({
    super.key,
    required this.fromDate,
    required this.toDate,
    required this.onShowPicker,
    required this.onPickDate,
  });

  String _format(DateTime? date) {
    if (date == null) return 'Select date';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: _DateBox(
              label: 'From',
              date: _format(fromDate),
              onTap: () async {
                final picked = await onShowPicker(context, fromDate);
                if (picked != null) onPickDate(true, picked);
              },
              icon: Icons.date_range,
              color: ColorConstants.highlightPrimary,
              textColor: textColor,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _DateBox(
              label: 'To',
              date: _format(toDate),
              onTap: () async {
                final picked = await onShowPicker(context, toDate);
                if (picked != null) onPickDate(false, picked);
              },
              icon: Icons.event,
              color: ColorConstants.highlightPrimary,
              textColor: textColor,
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _DateBox extends StatelessWidget {
  final String label;
  final String date;
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  final Color? textColor;
  final Color backgroundColor;

  const _DateBox({
    required this.label,
    required this.date,
    required this.onTap,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorConstants.highlightPrimary),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      )),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Hàm mặc định cho showDatePicker với màu theme
Future<DateTime?> defaultShowDatePicker(
    BuildContext context, DateTime? initialDate) {
  final now = DateTime.now();
  return showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: now,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: ColorConstants.highlightPrimary,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: ColorConstants.highlightPrimary,
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}
