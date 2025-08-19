import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/shared/constants/colors.dart';
import 'comments_controller.dart';

class CommentsScreen extends GetView<CommentsController> {
  const CommentsScreen({super.key});

  void showAddCommentDialog(BuildContext context) {
    final controllerText = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Thêm comment"),
        content: TextField(
          controller: controllerText,
          decoration: const InputDecoration(hintText: "Nhập nội dung..."),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Hủy")),
          ElevatedButton(
              onPressed: () {
                if (controllerText.text.trim().isNotEmpty) {
                  Get.find<CommentsController>()
                      .addComment(controllerText.text.trim());
                  Navigator.pop(context);
                }
              },
              child: const Text("Lưu")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      body: Obx(() {
        final comments = controller.comments;
        if (comments.isEmpty) {
          return const Center(child: Text("Chưa có comment"));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            final time = DateTime.parse(comment["time"]);
            return Card(
              child: ListTile(
                leading: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white)),
                title: Text(comment["user"],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(comment["content"]),
                trailing: Text(
                  "${time.day.toString().padLeft(2, '0')}/"
                  "${time.month.toString().padLeft(2, '0')}/"
                  "${time.year} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddCommentDialog(context),
        backgroundColor: Colors.green,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
