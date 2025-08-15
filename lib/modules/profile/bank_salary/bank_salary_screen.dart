import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_manager/shared/constants/colors.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import 'bank_salary_controller.dart';

class BankSalaryScreen extends GetView<BankSalaryController> {
  const BankSalaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        foregroundColor: ColorConstants.white,
        title: const Text(
          "Bank & Salary",
          style: TextStyle(color: ColorConstants.white),
        ),
        backgroundColor: ColorConstants.highlightPrimary,
        centerTitle: true,
      ),
      body: Obx(() => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
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
                    // Payment Type Dropdown
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: DropdownButtonFormField<String>(
                        value: controller.selectedPaymentType.value.isNotEmpty 
                            ? controller.selectedPaymentType.value 
                            : null,
                        items: controller.paymentTypeList
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Container(
                                    color: Colors.white,
                                    child: Text(
                                      type,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.highlightPrimary,
                                      ),
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
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.payment, color: ColorConstants.highlightPrimary),
                          labelText: "Payment Type",
                          labelStyle: const TextStyle(fontSize: 16, color: ColorConstants.highlightPrimary),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: ColorConstants.highlightPrimary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: ColorConstants.highlightPrimary, width: 1.5),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
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
                          controller.selectedPaymentType.value.isNotEmpty 
                              ? controller.selectedPaymentType.value 
                              : "No payment type selected",
                          style: const TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.w600, 
                            color: ColorConstants.highlightPrimary
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
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
          )),
      floatingActionButton: Obx(() => FloatingActionButton(
            backgroundColor: ColorConstants.highlightPrimary,
            onPressed: controller.toggleEdit,
            child: Icon(controller.isEditing.value ? Icons.save : Icons.edit),
          )),
    );
  }
}