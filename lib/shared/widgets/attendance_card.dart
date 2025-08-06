import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceCard extends StatelessWidget {
  final String? date;
  final String? checkIn;
  final String? checkOut;
  final VoidCallback? onTap;

  const AttendanceCard({
    super.key,
    this.date,
    this.checkIn,
    this.checkOut,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = _formatDateWithWeekday(date);
    final formattedCheckIn = _formatTime(checkIn);
    final formattedCheckOut = _formatTime(checkOut);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.brightness == Brightness.dark
              ? theme.colorScheme.surface
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
         boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:  0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 6),
                Text(
                  formattedDate,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                _buildTimeInfo(
                  icon: Icons.login,
                  color: Colors.green,
                  time: formattedCheckIn,
                ),
                const SizedBox(width: 20),
                _buildTimeInfo(
                  icon: Icons.logout,
                  color: Colors.red,
                  time: formattedCheckOut,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeInfo({
    required IconData icon,
    required Color color,
    required String time,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 4),
        Text(time),
      ],
    );
  }

  String _formatTime(String? time) {
    if (time == null || time.isEmpty) return '---';
    try {
      return DateFormat('HH:mm').format(DateTime.parse(time));
    } catch (_) {
      return time;
    }
  }

  String _formatDateWithWeekday(String? date) {
    if (date == null || date.isEmpty) return '-';
    try {
      final dt = DateTime.parse(date);
      final weekday = _weekdayEn(dt.weekday);
      final formatted = DateFormat('dd/MM/yyyy').format(dt);
      return '$weekday, $formatted';
    } catch (_) {
      if (date.contains('T')) {
        final parts = date.split('T')[0].split('-');
        final formatted = parts.reversed.join('/');
        return formatted;
      }
      return date;
    }
  }

  String _weekdayEn(int weekday) {
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    return weekdays[(weekday - 1) % 7];
  }
}
