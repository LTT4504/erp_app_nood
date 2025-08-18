import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/shared/constants/colors.dart';
import 'package:work_manager/shared/widgets/custom_text_form_field.dart';
import 'package:work_manager/shared/widgets/edit_fab.dart';
import 'package:work_manager/shared/widgets/action_buttons.dart';
import 'education_controller.dart';

class EducationScreen extends GetView<EducationController> {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        foregroundColor: ColorConstants.white,
        title: const Text(
          "Education",
          style: TextStyle(color: ColorConstants.white),
        ),
        backgroundColor: ColorConstants.highlightPrimary,
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabeledCard(
                    label: "Education",
                    children: [
                      _buildCustomField(
                          "Education Information",
                          "Enter education info",
                          Icons.school,
                          controller.educationInfoController,
                          controller.isEditing.value),
                      _buildCustomField(
                          "Soft Skills",
                          "Enter soft skills",
                          Icons.lightbulb,
                          controller.softSkillsController,
                          controller.isEditing.value),
                      _buildCustomField(
                          "Business Experience",
                          "Enter business experience",
                          Icons.work,
                          controller.businessExpController,
                          controller.isEditing.value),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildLabeledCard(
                    label: "Foreign Languages",
                    children: [
                      _buildCustomField(
                          "English",
                          "Enter English level",
                          Icons.language,
                          controller.englishController,
                          controller.isEditing.value),
                      _buildCustomField(
                          "Japanese",
                          "Enter Japanese level",
                          Icons.translate,
                          controller.japaneseController,
                          controller.isEditing.value),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            )),
      bottomNavigationBar: Obx(() => controller.isEditing.value
          ? Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: ActionButtons(
                onCancel: controller.cancelEdit,
                onSave: controller.saveEducationInfo,
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

  Widget _buildLabeledCard(
      {required String label, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorConstants.highlightPrimary),
        ),
        const SizedBox(height: 8),
        Card(
          color: ColorConstants.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: children
                  .map((child) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: child,
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomField(String label, String hint, IconData icon,
      TextEditingController controller, bool isEditing) {
    return CustomTextFormField(
      label: label,
      hint: hint,
      icon: icon,
      primaryColor: Colors.green,
      controller: controller,
      readOnly: !isEditing,
    );
  }
}
