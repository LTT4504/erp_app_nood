import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DescriptionController extends GetxController {
  final box = GetStorage();
  final description = "".obs;

  final String storageKey = "description";

  @override
  void onInit() {
    super.onInit();
    String? stored = box.read(storageKey);
    if (stored != null) {
      description.value = stored;
    }
  }

  void updateDescription(String text) {
    description.value = text;
    _saveToStorage();
  }

  void _saveToStorage() {
    box.write(storageKey, description.value);
  }
}
