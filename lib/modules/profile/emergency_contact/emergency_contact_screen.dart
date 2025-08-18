import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/shared/constants/colors.dart';
import 'package:work_manager/shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/action_buttons.dart';
import '../../../shared/widgets/edit_fab.dart';
import 'emergency_contact_controller.dart';

class EmergencyContactScreen extends GetView<EmergencyContactController> {
  const EmergencyContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        backgroundColor: ColorConstants.highlightPrimary,
        title: const Text("Emergency Contact", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Primary Contact", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorConstants.highlightPrimary)),
              const SizedBox(height: 8),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        label: "Full Name",
                        hint: "Full Name",
                        icon: Icons.person,
                        primaryColor: ColorConstants.highlightPrimary,
                        controller: controller.primaryNameController,
                        readOnly: !controller.isEditing.value,
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        label: "Relationship",
                        hint: "Relationship",
                        icon: Icons.group,
                        primaryColor: ColorConstants.highlightPrimary,
                        controller: controller.primaryRelationshipController,
                        readOnly: !controller.isEditing.value,
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        label: "Phone Number",
                        hint: "Phone Number",
                        icon: Icons.phone,
                        primaryColor: ColorConstants.highlightPrimary,
                        controller: controller.primaryPhoneController,
                        readOnly: !controller.isEditing.value,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Secondary Contact", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: ColorConstants.highlightPrimary)),
              const SizedBox(height: 8),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        label: "Full Name",
                        hint: "Full Name",
                        icon: Icons.person,
                        primaryColor: ColorConstants.highlightPrimary,
                        controller: controller.secondaryNameController,
                        readOnly: !controller.isEditing.value,
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        label: "Relationship",
                        hint: "Relationship",
                        icon: Icons.group,
                        primaryColor: ColorConstants.highlightPrimary,
                        controller: controller.secondaryRelationshipController,
                        readOnly: !controller.isEditing.value,
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        label: "Phone Number",
                        hint: "Phone Number",
                        icon: Icons.phone,
                        primaryColor: ColorConstants.highlightPrimary,
                        controller: controller.secondaryPhoneController,
                        readOnly: !controller.isEditing.value,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          );
        }),
      ),
      bottomNavigationBar: Obx(() => controller.isEditing.value
          ? Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: ActionButtons(
                onCancel: controller.cancelEdit,
                onSave: controller.saveContact,
              ),
            )
          : const SizedBox.shrink()),
     floatingActionButton: EditFAB(
  isEditing: controller.isEditing,
  onEdit: () {
    controller.isEditing.value = true;
  },
),

    );
  }
}
