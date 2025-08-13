import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/constants/colors.dart';
import 'task_detail_controller.dart';

class TaskDetailScreen extends GetView<TaskDetailController> {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? task = Get.arguments as Map<String, dynamic>?;

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: ColorConstants.highlightPrimaryPastel,
        appBar: AppBar(
          backgroundColor: ColorConstants.highlightPrimary,
          elevation: 2,
          shadowColor: Colors.black26,
          title: const Text(
            'Task Detail',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              color: ColorConstants.highlightPrimaryPastel,
              child: const TabBar(
                isScrollable: true,
                indicatorColor:ColorConstants.highlightPrimary,
                indicatorWeight: 3,
                labelColor: ColorConstants.highlightPrimary,
                unselectedLabelColor: Colors.black, 
                labelStyle: TextStyle(fontWeight: FontWeight.w600),
                tabAlignment: TabAlignment.start,
                tabs: [
                  Tab(text: 'Information'),
                  Tab(text: 'Description'),
                  Tab(text: 'Comments'),
                  Tab(text: 'Document'),
                  Tab(text: 'Sub Tasks'),
                  Tab(text: 'History'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Information
            Padding(
              padding: const EdgeInsets.all(16),
              child: (task == null)
                  ? const Center(
                      child: Text(
                        "Không có dữ liệu",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          shadowColor: Colors.black26,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title + edit
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        task['title'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: ColorConstants.highlightPrimaryPastel,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: ColorConstants.highlightPrimary,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Info list
                                _buildInfoItem(Icons.layers, 'Parent Task',
                                    task['parentTask'] ?? ''),
                                _buildInfoItem(Icons.flag, 'Status',
                                    task['status'] ?? ''),
                                _buildInfoItem(Icons.priority_high, 'Priority',
                                    task['priority'] ?? ''),
                                _buildInfoItem(Icons.person, 'Assignee',
                                    task['assignee'] ?? ''),
                                _buildInfoItem(Icons.timer, 'Completed time',
                                    task['completedTime'] ?? '-- hours'),
                                _buildInfoItem(Icons.access_time, 'Estimated time',
                                    task['estimatedTime'] ?? '-- hours'),
                                _buildInfoItem(Icons.calendar_today, 'From date',
                                    task['fromDate'] ?? ''),
                                _buildInfoItem(Icons.event, 'To date',
                                    task['toDate'] ?? ''),
                                const SizedBox(height: 16),
                                const Text(
                                  'Progress',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value: ((task['progress'] as num? ?? 0) /
                                            100)
                                        .clamp(0.0, 1.0),
                                    backgroundColor: Colors.grey.shade300,
                                    color: ColorConstants.highlightPrimary,
                                    minHeight: 10,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${task['progress'] ?? 0}%',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.access_time, color: Colors.white),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.highlightPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              // Xử lý log time
                            },
                            label: const Text(
                              'Log Time',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            const Center(child: Text("Description content")),
            const Center(child: Text("Comments content")),
            const Center(child: Text("Document content")),
            const Center(child: Text("Sub Tasks content")),
            const Center(child: Text("History content")),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: ColorConstants.highlightPrimary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
