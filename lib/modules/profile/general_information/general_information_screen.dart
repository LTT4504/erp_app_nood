import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/widgets/action_buttons.dart';
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
        actions: [
          Obx(() {
            if (!controller.isEditing.value) {
              return IconButton(
                icon: const Icon(Icons.edit, size: 24),
                tooltip: "Edit Information",
                onPressed: controller.enableEditing,
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            Card(
              color: ColorConstants.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(color: ColorConstants.highlightPrimary.withOpacity(0.18)),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Column(
                  children: [
                    _buildTextField(Icons.person, 'Full Name', controller.fullNameController),
                    _buildTextField(Icons.tag, 'Nickname', controller.nickNameController),
                    _buildTextField(Icons.cake, 'Birthday', controller.birthdayController),
                    _buildTextField(Icons.wc, 'Gender', controller.genderController),
                    _buildTextField(Icons.phone, 'Phone Number', controller.phoneNumberController),
                    _buildTextField(Icons.credit_card, 'ID Number', controller.idNumberController),
                    _buildTextField(Icons.date_range, 'Provide Date', controller.provideDateController),
                    _buildTextField(Icons.place, 'Provide Place', controller.providePlaceController),
                    _buildTextField(Icons.favorite, 'Marital Status', controller.maritalStatusController),
                    _buildTextField(Icons.child_care, 'Number of Children', controller.numberOfChildrenController),
                    _buildTextField(Icons.location_on, 'Place of Birth', controller.placeOfBirthController),
                    _buildTextField(Icons.home, 'Permanent Address', controller.addressController),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (controller.isEditing.value)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ActionButtons(
                  onCancel: controller.cancelEditing,
                  onSave: controller.updateUserInfo,
                ),
              ),
          ],
        );
      }),
    );
  }

  // general_information_screen.dart
Widget _buildTextField(
    IconData icon, String label, TextEditingController controllerField) {
  final controller = Get.find<GeneralInformationController>();
  final isEditing = controller.isEditing.value;
  final isBirthday = label == 'Birthday';
  final isProvideDate = label == 'Provide Date';
  final isGender = label == 'Gender';
  final genderOptions = ['Male', 'Female', 'Other'];

  // const activeFillColor = Colors.white; 
        // final inactiveFillColor = ColorConstants.highlightPrimaryPastel.withOpacity(0.18);

  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: isGender
        ? DropdownButtonFormField<String>(
            value: controllerField.text.isNotEmpty ? controllerField.text : null,
            items: genderOptions
                .map((g) => DropdownMenuItem(
                      value: g,
                      child: Container(
                        color: Colors.white,
                        child: Text(
                          g,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.highlightPrimary,
                          ),
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
              labelStyle: const TextStyle(fontSize: 16, color: ColorConstants.highlightPrimary),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: ColorConstants.highlightPrimary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: ColorConstants.highlightPrimary, width: 1.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            ),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ColorConstants.highlightPrimary,
            ),
            disabledHint: Text(
              controllerField.text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.highlightPrimary),
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
