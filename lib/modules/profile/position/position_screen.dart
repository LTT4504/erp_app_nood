import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/shared/constants/colors.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/edit_fab.dart';
import '../../../shared/widgets/action_buttons.dart';
import 'position_controller.dart';

class PositionScreen extends GetView<PositionController> {
  const PositionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        foregroundColor: ColorConstants.white,
        title: const Text(
          "Position",
          style: TextStyle(color: ColorConstants.white),
        ),
        backgroundColor: ColorConstants.highlightPrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildLabeledCard(
              label: "Position Details",
              children: [
                _buildCustomField("Job Title", "Enter your job title",
                    Icons.work, controller.jobTitleController),
                _buildCustomField("Department", "Enter your department",
                    Icons.apartment, controller.departmentController),
                _buildCustomField("Work Location", "Enter work location",
                    Icons.location_on, controller.workLocationController),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => controller.isEditing.value
          ? Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: ActionButtons(
                onCancel: controller.cancelEdit,
                onSave: controller.saveData,
              ),
            )
          : const SizedBox.shrink()),
      floatingActionButton: Obx(() => !controller.isEditing.value
          ? EditFAB(
              isEditing: controller.isEditing,
              onEdit: controller.toggleEdit,
            )
          : const SizedBox.shrink()),
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
            color: ColorConstants.highlightPrimary,
          ),
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
      TextEditingController controller) {
    return Obx(() => CustomTextFormField(
          label: label,
          hint: hint,
          icon: icon,
          primaryColor: Colors.green,
          controller: controller,
          readOnly: !this.controller.isEditing.value,
        ));
  }
}
