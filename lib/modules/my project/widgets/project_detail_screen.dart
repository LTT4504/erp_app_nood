import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/constants/colors.dart';
import 'project_detail_controller.dart';

class ProjectDetailScreen extends GetView<ProjectDetailController> {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        title: const Text("Project Detail"),
        centerTitle: true,
        backgroundColor: ColorConstants.highlightPrimary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final project = controller.project;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Avatar placeholder
              const CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white,
                child: Icon(Icons.image, size: 45, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // 🔹 Info box (bao gồm cả Name + Badge)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Project name + Badge (đưa vào card)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          project['name'] ?? 'No name',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text("New",
                              style: TextStyle(color: Colors.blue, fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // 🔹 Các dòng thông tin
                    _infoRow("Type", project['type'] ?? 'N/A'),
                    const Divider(height: 1, color: Colors.grey),
                    _infoRow("Time completed", "${project['time'] ?? '999'} hour"),
                    const Divider(height: 1, color: Colors.grey),
                    _infoRow("Start date", project['startDate'] ?? '15/04/2025'),
                    const Divider(height: 1, color: Colors.grey),
                    _infoRow("End date", project['endDate'] ?? '15/04/2025'),
                    const Divider(height: 1, color: Colors.grey),
                    _infoRow("Client", project['client'] ?? 'NinePlus'),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 Task section
              _sectionItem("Task", "All(0)"),

              // 🔹 Member section
              _sectionItem("Member", "All(1)",
                  child: const Row(
                    children: [
                      Icon(Icons.account_circle, size: 28, color: Colors.grey),
                      SizedBox(width: 8),
                      Text("Quang LV"),
                    ],
                  )),

              // 🔹 Description section
              _sectionItem("Description", "More",
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("WITHIN SCOPE:"),
                  )),

              // 🔹 Technologies section
              _sectionItem("Technologies", "More",
                  child: const Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Chip(label: Text(".NET")),
                      Chip(label: Text("Flutter")),
                      Chip(label: Text("PostgreSQL")),
                    ],
                  )),
            ],
          ),
        );
      }),
    );
  }

  /// 🔹 Row trong Info Card
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        ],
      ),
    );
  }

  /// 🔹 Section box (Task, Member, Description, Technologies)
  Widget _sectionItem(String title, String action, {Widget? child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Title + Action link
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500)),
              Text(action, style: const TextStyle(color: Colors.green)),
            ],
          ),
          if (child != null) ...[
            const SizedBox(height: 10),
            child,
          ],
        ],
      ),
    );
  }
}
