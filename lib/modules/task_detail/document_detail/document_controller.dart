import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DocumentController extends GetxController {
  final box = GetStorage();
  final documents = <String>[].obs;

  final String storageKey = "documents";

  @override
  void onInit() {
    super.onInit();
    List? stored = box.read(storageKey);
    if (stored != null) {
      documents.assignAll(List<String>.from(stored));
    }
  }

  void addDocument(String doc) {
    documents.add(doc);
    _saveToStorage();
  }

  void _saveToStorage() {
    box.write(storageKey, documents);
  }
}
