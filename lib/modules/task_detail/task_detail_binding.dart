import 'package:get/get.dart';
import 'comment_detail/comments_controller.dart';
import 'description_detail/description_controller.dart';
import 'document_detail/document_controller.dart';
import 'subtask_detail/subtask_controller.dart';
import 'task_detail_controller.dart';

class TaskDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Controller chính của Task Detail
    Get.lazyPut<TaskDetailController>(() => TaskDetailController());

    // Các tab con
    Get.lazyPut<CommentsController>(() => CommentsController());
    Get.lazyPut<DescriptionController>(() => DescriptionController());
    Get.lazyPut<DocumentController>(() => DocumentController());
    Get.lazyPut<SubTaskController>(() => SubTaskController());
  }
}
