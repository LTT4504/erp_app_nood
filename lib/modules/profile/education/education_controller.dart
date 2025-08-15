import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EducationController extends GetxController {
  final box = GetStorage();

  var educationInfo = "".obs;
  var softSkills = "".obs;
  var businessExperience = "".obs;
  var englishLevel = "".obs;
  var japaneseLevel = "".obs;

  var isEditing = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    educationInfo.value = box.read('educationInfo') ?? "Đại học VKU";
    softSkills.value = box.read('softSkills') ?? "KNM";
    businessExperience.value = box.read('businessExperience') ?? "Dài Dài";
    englishLevel.value = box.read('englishLevel') ?? "9.0";
    japaneseLevel.value = box.read('japaneseLevel') ?? "5.2";
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }

  void saveData() {
    box.write('educationInfo', educationInfo.value);
    box.write('softSkills', softSkills.value);
    box.write('businessExperience', businessExperience.value);
    box.write('englishLevel', englishLevel.value);
    box.write('japaneseLevel', japaneseLevel.value);

    isEditing.value = false;
  }
}
