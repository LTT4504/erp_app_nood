// import 'package:flutter/material.dart';
// import '../../../shared/constants/colors.dart';

// class TaskCard extends StatelessWidget {
//   final Map<String, dynamic> task;
//   final VoidCallback? onTap;

//   const TaskCard({
//     super.key,
//     required this.task,
//     this.onTap,
//   });

//   Color _getPriorityColor(String priority) {
//     switch (priority.toLowerCase()) {
//       case 'high':
//         return Colors.red;
//       case 'medium':
//         return Colors.orange;
//       default:
//         return Colors.blue;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     final String title = task['title'] ?? '';
//     final String subtitle = task['project'] ?? task['subtitle'] ?? '';
//     final String priority = task['priority'] ?? 'Low';
//     final String status = task['status'] ?? 'To do';
//     final int progress = (task['progress'] as num?)?.toInt() ?? 0;
//     final String datetime = task['datetime'] ?? '';

//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         margin: const EdgeInsets.only(bottom: 16),
//         color: isDark ? ColorConstants.darkGray : ColorConstants.white,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Tiêu đề và trạng thái
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       title,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: isDark ? ColorConstants.white : ColorConstants.black,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: _getPriorityColor(priority).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       status,
//                       style: TextStyle(
//                         color: _getPriorityColor(priority),
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4),

//               // Subtitle / project name
//               Text(
//                 subtitle,
//                 style: TextStyle(
//                   color: isDark ? Colors.grey.shade400 : Colors.black54,
//                 ),
//               ),
//               const SizedBox(height: 8),

//               // Priority
//               Row(
//                 children: [
//                   Icon(Icons.priority_high,
//                       color: _getPriorityColor(priority), size: 16),
//                   const SizedBox(width: 4),
//                   Text(
//                     priority,
//                     style: TextStyle(
//                       color: _getPriorityColor(priority),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),

//               // Progress bar
//               Row(
//                 children: [
//                   Icon(Icons.access_time,
//                       size: 16,
//                       color: isDark ? ColorConstants.white : ColorConstants.black),
//                   const SizedBox(width: 4),
//                   Expanded(
//                     child: LinearProgressIndicator(
//                       value: (progress / 100).clamp(0.0, 1.0),
//                       backgroundColor: Colors.grey.shade300,
//                       color: _getPriorityColor(priority),
//                       minHeight: 8,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     "$progress%",
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),

//               const Divider(height: 24),

//               // Footer: icon + datetime
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Icon(Icons.person_outline,
//                       color: isDark ? ColorConstants.white : ColorConstants.black),
//                   Text(
//                     datetime,
//                     style: TextStyle(
//                       color: isDark ? Colors.grey.shade400 : Colors.black54,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
