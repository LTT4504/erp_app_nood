import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/widgets/action_buttons.dart';
import '../../../shared/widgets/edit_fab.dart';
import 'general_information_controller.dart';
import '../../../shared/widgets/date_range_picker.dart';
import '../../../shared/widgets/custom_text_form_field.dart';

class GeneralInformationScreen extends GetView<GeneralInformationController> {
  const GeneralInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        title: const Text(
          'General Information',
          style: TextStyle(
            color: ColorConstants.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: ColorConstants.highlightPrimary,
        elevation: 0.5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorConstants.white),
      ),
      body: Obx(() {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            Card(
              color: ColorConstants.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(
                  color: ColorConstants.highlightPrimary.withOpacity(0.18),
                ),
              ),
              elevation: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Column(
                  children: [
                    _buildTextField(Icons.person, 'Full Name',
                        controller.fullNameController),
                    _buildTextField(
                        Icons.tag, 'Nickname', controller.nickNameController),
                    _buildTextField(
                        Icons.cake, 'Birthday', controller.birthdayController),
                    _buildTextField(
                        Icons.wc, 'Gender', controller.genderController),
                    _buildTextField(Icons.phone, 'Phone Number',
                        controller.phoneNoController),
                    _buildTextField(Icons.credit_card, 'ID Number',
                        controller.identityCardController),
                    _buildTextField(Icons.date_range, 'Provide Date',
                        controller.provideDateIdentityCardController),
                    _buildTextField(Icons.place, 'Provide Place',
                        controller.providePlaceIdentityCardController),
                    _buildTextField(Icons.favorite, 'Marital Status',
                        controller.maritalStatusController),
                    _buildTextField(Icons.child_care, 'Number of Children',
                        controller.numberChildController),
                    _buildTextField(Icons.location_on, 'Place of Birth',
                        controller.placeOfBirthController),
                    _buildTextField(Icons.home, 'Permanent Address',
                        controller.addressController),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80), // chừa chỗ cho ActionButtons
            if (controller.isEditing.value)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ActionButtons(
                  onCancel: () => controller.isEditing.value = false,
                  onSave: controller.updateGeneralInformation,
                ),
              ),
          ],
        );
      }),
      floatingActionButton: EditFAB(
        isEditing: controller.isEditing,
        onEdit: () {
          controller.isEditing.value = true;
        },
      ),
    );
  }

  Widget _buildTextField(
      IconData icon, String label, TextEditingController controllerField) {
    final controller = Get.find<GeneralInformationController>();
    final isEditing = controller.isEditing.value;
    final isBirthday = label == 'Birthday';
    final isProvideDate = label == 'Provide Date';
    final isGender = label == 'Gender';
    final genderOptions = ['0', '1', '2']; // 0=Male, 1=Female, 2=Other

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: isGender
          ? DropdownButtonFormField<String>(
              value:
                  controllerField.text.isNotEmpty ? controllerField.text : null,
              items: genderOptions
                  .map((g) => DropdownMenuItem(
                        value: g,
                        child: Text(
                          g == '0'
                              ? "Male"
                              : g == '1'
                                  ? "Female"
                                  : "Other",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.highlightPrimary,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: isEditing
                  ? (val) {
                      controllerField.text = val ?? '';
                    }
                  : null,
              dropdownColor: Colors.white,
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: ColorConstants.highlightPrimary),
                labelText: label,
                labelStyle: const TextStyle(
                    fontSize: 16, color: ColorConstants.highlightPrimary),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              disabledHint: Text(
                controllerField.text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.highlightPrimary,
                ),
              ),
            )
          : (isBirthday || isProvideDate)
              ? GestureDetector(
                  onTap: isEditing
                      ? () async {
                          DateTime? picked = await defaultShowDatePicker(
                            Get.context!,
                            DateTime.tryParse(controllerField.text),
                          );
                          if (picked != null) {
                            controllerField.text =
                                '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                          }
                        }
                      : null,
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      label: label,
                      hint: label,
                      icon: icon,
                      primaryColor: ColorConstants.highlightPrimary,
                      controller: controllerField,
                      obscureText: false,
                      readOnly: true,
                      suffix: const Icon(Icons.calendar_today, size: 20),
                    ),
                  ),
                )
              : CustomTextFormField(
                  label: label,
                  hint: label,
                  icon: icon,
                  primaryColor: ColorConstants.highlightPrimary,
                  controller: controllerField,
                  obscureText: false,
                  readOnly: !isEditing,
                ),
    );
  }
}
