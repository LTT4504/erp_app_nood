import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommentsController extends GetxController {
  final storage = GetStorage();

  var comments = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadComments();
  }

  void loadComments() {
    final storedData = storage.read<List>('comments');
    if (storedData != null) {
      comments.value =
          storedData.map((e) => Map<String, dynamic>.from(e)).toList();
    }
  }

  void addComment(String content) {
    final newComment = {
      "user": "admin - Quang LV",
      "time": DateTime.now().toIso8601String(),
      "content": content,
    };
    comments.insert(0, newComment);
    storage.write('comments', comments);
  }
}
