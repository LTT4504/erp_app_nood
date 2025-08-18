import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/shared/constants/colors.dart';

import '../../../models/model/user_model.dart';
import '../../../shared/services/user_service.dart';

class GeneralInformationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isEditing = false.obs;

  // Text controllers
  final fullNameController = TextEditingController();
  final nickNameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final birthdayController = TextEditingController();
  final genderController = TextEditingController();
  final maritalStatusController = TextEditingController();
  final numberChildController = TextEditingController();
  final placeOfBirthController = TextEditingController();
  final addressController = TextEditingController();
  final identityCardController = TextEditingController();
  final provideDateIdentityCardController = TextEditingController();
  final providePlaceIdentityCardController = TextEditingController();

  // Load từ API
  Future<void> fetchGeneralInformation() async {
    try {
      final user = await UserService.getMe();
      if (user != null) {
        _fillControllers(user);
      } else {
        Get.snackbar("Error", "Invalid Employee",
            backgroundColor: ColorConstants.red,
            colorText: ColorConstants.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch general information",
          backgroundColor: ColorConstants.red,
          colorText: ColorConstants.white);
    }
  }

  // Update API
  Future<void> updateGeneralInformation() async {
    if (!formKey.currentState!.validate()) return;

    try {
      final user = _getUserFromControllers();
      final success = await UserService.updateMe(user);

      if (success) {
        Get.snackbar("Success", "Profile updated successfully",
            backgroundColor: ColorConstants.green,
            colorText: ColorConstants.white);
        isEditing.value = false;
      } else {
        Get.snackbar("Error", "Update failed",
            backgroundColor: ColorConstants.red,
            colorText: ColorConstants.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile",
          backgroundColor: ColorConstants.red,
          colorText: ColorConstants.white);
    }
  }

  // Helper
  void _fillControllers(UserModel user) {
    fullNameController.text = user.fullName ?? '';
    nickNameController.text = user.nickName ?? '';
    phoneNoController.text = user.phoneNo ?? '';
    birthdayController.text = user.birthday ?? '';
    genderController.text = user.gender?.toString() ?? '';
    maritalStatusController.text = user.maritalStatus?.toString() ?? '';
    numberChildController.text = user.numberChild?.toString() ?? '';
    placeOfBirthController.text = user.placeOfBirth ?? '';
    addressController.text = user.address ?? '';
    identityCardController.text = user.identityCard ?? '';
    provideDateIdentityCardController.text = user.provideDateIdentityCard ?? '';
    providePlaceIdentityCardController.text = user.providePlaceIdentityCard ?? '';
  }

  UserModel _getUserFromControllers() {
    return UserModel(
      fullName: fullNameController.text,
      nickName: nickNameController.text,
      phoneNo: phoneNoController.text,
      birthday: birthdayController.text,
      gender: int.tryParse(genderController.text),
      maritalStatus: int.tryParse(maritalStatusController.text),
      numberChild: int.tryParse(numberChildController.text),
      placeOfBirth: placeOfBirthController.text,
      address: addressController.text,
      identityCard: identityCardController.text,
      provideDateIdentityCard: provideDateIdentityCardController.text,
      providePlaceIdentityCard: providePlaceIdentityCardController.text,
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchGeneralInformation();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    nickNameController.dispose();
    phoneNoController.dispose();
    birthdayController.dispose();
    genderController.dispose();
    maritalStatusController.dispose();
    numberChildController.dispose();
    placeOfBirthController.dispose();
    addressController.dispose();
    identityCardController.dispose();
    provideDateIdentityCardController.dispose();
    providePlaceIdentityCardController.dispose();
    super.onClose();
  }
}
