import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmergencyContactController extends GetxController {
  var isEditing = false.obs;

  // Primary Contact
  final primaryNameController = TextEditingController();
  final primaryRelationshipController = TextEditingController();
  final primaryPhoneController = TextEditingController();

  // Secondary Contact
  final secondaryNameController = TextEditingController();
  final secondaryRelationshipController = TextEditingController();
  final secondaryPhoneController = TextEditingController();

  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }

  void cancelEdit() {
    isEditing.value = false;
  }

  void saveContact() {
    // TODO: Gọi API lưu dữ liệu
    isEditing.value = false;
  }

  @override
  void onClose() {
    primaryNameController.dispose();
    primaryRelationshipController.dispose();
    primaryPhoneController.dispose();
    secondaryNameController.dispose();
    secondaryRelationshipController.dispose();
    secondaryPhoneController.dispose();
    super.onClose();
  }
}
