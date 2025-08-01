// widgets/attendance_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceCard extends StatelessWidget {
  final String? date;
  final String? checkIn;
  final String? checkOut;

  const AttendanceCard({
    super.key,
    this.date,
    this.checkIn,
    this.checkOut,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatDate(date);
    final formattedCheckIn = _formatTime(checkIn);
    final formattedCheckOut = _formatTime(checkOut);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text(formattedDate, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Vào: $formattedCheckIn — Ra: $formattedCheckOut'),
      ),
    );
  }

  String _formatTime(String? time) {
    if (time == null || time.isEmpty) return '-';
    try {
      return DateFormat('HH:mm').format(DateTime.parse(time));
    } catch (_) {
      return time;
    }
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return '-';
    try {
      final dt = DateTime.parse(date);
      return DateFormat('EEEE, dd/MM/yyyy', 'vi').format(dt);
    } catch (_) {
      return date;
    }
  }
}
