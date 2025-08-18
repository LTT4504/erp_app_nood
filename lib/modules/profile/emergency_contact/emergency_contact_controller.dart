import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/model/emergency_contact_model.dart';
import '../../../shared/services/emergency_contact_service.dart';


class EmergencyContactController extends GetxController {
  var isEditing = false.obs;
  final EmergencyContactService _service = EmergencyContactService();

  // Primary Contact
  final primaryNameController = TextEditingController();
  final primaryRelationshipController = TextEditingController();
  final primaryPhoneController = TextEditingController();

  // Secondary Contact
  final secondaryNameController = TextEditingController();
  final secondaryRelationshipController = TextEditingController();
  final secondaryPhoneController = TextEditingController();

  EmergencyContact? contact;

  @override
  void onInit() {
    super.onInit();
    fetchContact();
  }

  Future<void> fetchContact() async {
    try {
      contact = await _service.fetchContact();

      primaryNameController.text = contact?.namePrimaryContact ?? "";
      primaryRelationshipController.text = contact?.relationshipPrimaryContact ?? "";
      primaryPhoneController.text = contact?.phoneNoPrimaryContact ?? "";
      secondaryNameController.text = contact?.nameSecondaryContact ?? "";
      secondaryRelationshipController.text = contact?.relationshipSecondaryContact ?? "";
      secondaryPhoneController.text = contact?.phoneNoSecondaryContact ?? "";
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch contact");
    }
  }

  Future<void> saveContact() async {
    try {
      final updatedContact = EmergencyContact(
        namePrimaryContact: primaryNameController.text,
        relationshipPrimaryContact: primaryRelationshipController.text,
        phoneNoPrimaryContact: primaryPhoneController.text,
        nameSecondaryContact: secondaryNameController.text,
        relationshipSecondaryContact: secondaryRelationshipController.text,
        phoneNoSecondaryContact: secondaryPhoneController.text,
      );

      await _service.saveContact(updatedContact);

      Get.snackbar("Success", "Emergency contact updated successfully");
      isEditing.value = false;
    } catch (e) {
      Get.snackbar("Error", "Failed to update contact");
    }
  }

  void toggleEdit() => isEditing.value = !isEditing.value;

  void cancelEdit() {
    isEditing.value = false;
    fetchContact();
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
