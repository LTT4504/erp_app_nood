import 'package:flutter/material.dart';

class HomeMenuGrid extends StatelessWidget {
  const HomeMenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.access_time,
        'label': 'Attendance',
        'bgColor': const Color(0xFFE3F3FE),
        'iconColor': const Color(0xFF1994F2),
      },
      {
        'icon': Icons.calendar_today,
        'label': 'My calendar',
        'bgColor': const Color(0xFFFFF3E3),
        'iconColor': const Color(0xFFFFA500),
      },
      {
        'icon': Icons.note_add,
        'label': 'Request Leave',
        'bgColor': const Color(0xFFE3FAE5),
        'iconColor': const Color(0xFF4CAF50),
      },
      {
        'icon': Icons.task,
        'label': 'My Tasks',
        'bgColor': const Color(0xFFF3E3FA),
        'iconColor': const Color(0xFF9C27B0),
      },
      {
        'icon': Icons.work,
        'label': 'My Projects',
        'bgColor': const Color(0xFFFFE4E3),
        'iconColor': const Color(0xFFFF4D4D),
      },
      {
        'icon': Icons.event,
        'label': 'Annual Calendar',
        'bgColor': const Color(0xFFE3F0FA),
        'iconColor': const Color(0xFF00BCD4),
      },
      {
        'icon': Icons.more_horiz,
        'label': 'Other',
        'bgColor': const Color(0xFFE0E0E0),
        'iconColor': const Color(0xFF757575),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.85,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (_, index) {
          final item = items[index];
          return Column(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: item['bgColor'] as Color,
                child: Icon(
                  item['icon'] as IconData,
                  color: item['iconColor'] as Color,
                  size: 30,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item['label'].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          );
        },
      ),
    );
  }
}
