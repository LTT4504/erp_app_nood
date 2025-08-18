// bank_salary_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/lang/app_language_key.dart';
import 'package:work_manager/shared/constants/colors.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/action_buttons.dart';
import '../../../shared/widgets/edit_fab.dart';
import 'bank_salary_controller.dart';

class BankSalaryScreen extends GetView<BankSalaryController> {
  const BankSalaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        foregroundColor: ColorConstants.white,
        title: Text(
          AppLanguageKey.bankAndSalary.tr,
          style: const TextStyle(color: ColorConstants.white),
        ),
        backgroundColor: ColorConstants.highlightPrimary,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                surfaceTintColor: ColorConstants.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        label: "Bank Name",
                        hint: "Enter bank name",
                        icon: Icons.account_balance,
                        primaryColor: ColorConstants.highlightPrimary,
                        controller: controller.bankNameController,
                        readOnly: !controller.isEditing.value,
                      ),
                      const SizedBox(height: 12),
                      CustomTextFormField(
                        label: "Account Name",
                        hint: "Enter account name",
                        icon: Icons.person,
                        primaryColor: ColorConstants.highlightPrimary,
                        controller: controller.accountNameController,
                        readOnly: !controller.isEditing.value,
                      ),
                      const SizedBox(height: 12),
                      CustomTextFormField(
                        label: "Account Number",
                        hint: "Enter account number",
                        icon: Icons.numbers,
                        primaryColor: ColorConstants.highlightPrimary,
                        controller: controller.accountNumberController,
                        readOnly: !controller.isEditing.value,
                      ),
                      const SizedBox(height: 12),
                      CustomTextFormField(
                        label: "Salary Basic",
                        hint: "Enter salary basic",
                        icon: Icons.money,
                        primaryColor: ColorConstants.highlightPrimary,
                        controller: controller.salaryBasicController,
                        readOnly: !controller.isEditing.value,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: controller.selectedPaymentType.value.isNotEmpty
                            ? controller.selectedPaymentType.value
                            : null,
                        items: controller.paymentTypeList
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(
                                    type,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.highlightPrimary,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: controller.isEditing.value
                            ? (val) {
                                if (val != null) {
                                  controller.selectedPaymentType.value = val;
                                }
                              }
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.payment,
                              color: ColorConstants.highlightPrimary),
                          labelText: "Payment Type",
                          labelStyle: const TextStyle(
                              fontSize: 16,
                              color: ColorConstants.highlightPrimary),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomTextFormField(
                        label: "Salary Gross",
                        hint: "Enter salary gross",
                        icon: Icons.attach_money,
                        primaryColor: ColorConstants.highlightPrimary,
                        controller: controller.salaryGrossController,
                        readOnly: !controller.isEditing.value,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() => controller.isEditing.value
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: ActionButtons(
                onCancel: controller.cancelEdit,
                onSave: controller.saveData,
              ),
            )
          : const SizedBox.shrink()),
      floatingActionButton: EditFAB(
        isEditing: controller.isEditing,
        onEdit: controller.toggleEdit,
      ),
    );
  }
}
