// bank_salary_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/model/bank_salary_model.dart';
import '../../../shared/services/bank_salary_service.dart';

class BankSalaryController extends GetxController {
  final isEditing = false.obs;
  final isLoading = false.obs;

  // Controllers
  final bankNameController = TextEditingController();
  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final salaryBasicController = TextEditingController();
  final salaryGrossController = TextEditingController();

  var selectedPaymentType = "".obs;
  final paymentTypeList = ["Cash", "Bank"]; // 0 = Cash, 1 = Bank

  var bankSalaryModel = Rxn<BankSalaryModel>();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      final data = await BankSalaryService.getBankSalary();
      if (data != null) {
        bankSalaryModel.value = data;
        _fillControllers(data);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _fillControllers(BankSalaryModel data) {
    bankNameController.text = data.bankName;
    accountNameController.text = data.bankAccountName;
    accountNumberController.text = data.bankNumber;
    salaryBasicController.text = data.salaryBasic.toString();
    salaryGrossController.text = data.salaryGross.toString();
    selectedPaymentType.value = data.paymentType == 0 ? "Cash" : "Bank";
  }

  Future<void> saveData() async {
    final model = BankSalaryModel(
      salaryBasic: int.tryParse(salaryBasicController.text) ?? 0,
      salaryGross: int.tryParse(salaryGrossController.text) ?? 0,
      bankName: bankNameController.text,
      bankNumber: accountNumberController.text,
      bankAccountName: accountNameController.text,
      paymentType: selectedPaymentType.value == "Cash" ? 0 : 1,
    );

    isLoading.value = true;
    final success = await BankSalaryService.updateBankSalary(model);
    isLoading.value = false;

    if (success) {
      Get.snackbar("✅ Success", "Bank & Salary updated successfully");
      bankSalaryModel.value = model;
      isEditing.value = false;
    } else {
      Get.snackbar("❌ Error", "Failed to update Bank & Salary info");
    }
  }

  void cancelEdit() {
    if (bankSalaryModel.value != null) {
      _fillControllers(bankSalaryModel.value!);
    }
    isEditing.value = false;
  }

  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }
}
