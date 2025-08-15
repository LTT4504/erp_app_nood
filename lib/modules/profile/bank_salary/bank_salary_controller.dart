import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankSalaryController extends GetxController {
  // Trạng thái đang sửa hay không
  var isEditing = false.obs;

  // Controllers cho các field
  final bankNameController = TextEditingController(text: "LTT");
  final accountNameController = TextEditingController(text: "Le Trong Tin");
  final accountNumberController = TextEditingController(text: "012121212222");
  final salaryBasicController = TextEditingController(text: "10000000");
  final salaryGrossController = TextEditingController(text: "10000000");

  // Payment Type dropdown
  var paymentTypeList = ["Bank Transfer", "Cash"];
  var selectedPaymentType = "Bank Transfer".obs;

  // Hàm bật/tắt chế độ sửa
  void toggleEdit() {
    if (isEditing.value) {
      saveData();
    }
    isEditing.value = !isEditing.value;
  }

  // Hàm lưu dữ liệu (có thể call API ở đây)
  void saveData() {
    debugPrint("Bank Name: ${bankNameController.text}");
    debugPrint("Account Name: ${accountNameController.text}");
    debugPrint("Account Number: ${accountNumberController.text}");
    debugPrint("Salary Basic: ${salaryBasicController.text}");
    debugPrint("Payment Type: ${selectedPaymentType.value}");
    debugPrint("Salary Gross: ${salaryGrossController.text}");
  }
}
