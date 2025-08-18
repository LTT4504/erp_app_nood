import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/model/education_model.dart';
import '../../../shared/services/education_service.dart';


class EducationController extends GetxController {
  final isLoading = false.obs;
  final isEditing = false.obs;

  // Controllers
  final educationInfoController = TextEditingController();
  final businessExpController = TextEditingController();
  final softSkillsController = TextEditingController();
  final englishController = TextEditingController();
  final japaneseController = TextEditingController();

  var educationModel = Rxn<EducationModel>();

  @override
  void onInit() {
    super.onInit();
    fetchEducationInfo();
  }

  Future<void> fetchEducationInfo() async {
    isLoading.value = true;
    final data = await EducationService.getEducationInfo();
    if (data != null) {
      educationModel.value = data;
      _fillControllers(data);
    }
    isLoading.value = false;
  }

  void _fillControllers(EducationModel data) {
    educationInfoController.text = data.education;
    businessExpController.text = data.businessExperience;
    softSkillsController.text = data.softSkills;
    englishController.text = data.englishLevel;
    japaneseController.text = data.japaneseLevel;
  }

  Future<void> saveEducationInfo() async {
    final model = EducationModel(
      education: educationInfoController.text,
      businessExperience: businessExpController.text,
      softSkills: softSkillsController.text,
      englishLevel: englishController.text,
      japaneseLevel: japaneseController.text,
    );

    final success = await EducationService.updateEducationInfo(model);
    if (success) {
      Get.snackbar("Success", "Education info updated successfully");
      educationModel.value = model;
      isEditing.value = false;
    } else {
      Get.snackbar("Error", "Failed to update education info");
    }
  }

  void cancelEdit() {
    if (educationModel.value != null) {
      _fillControllers(educationModel.value!);
    }
    isEditing.value = false;
  }
}
