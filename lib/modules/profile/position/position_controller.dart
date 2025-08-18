import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PositionController extends GetxController {
  final box = GetStorage();

  var isEditing = false.obs;

  late TextEditingController jobTitleController;
  late TextEditingController departmentController;
  late TextEditingController workLocationController;

  @override
  void onInit() {
    super.onInit();
    jobTitleController = TextEditingController(
        text: box.read("jobTitle") ?? "Software Engineer");
    departmentController = TextEditingController(
        text: box.read("department") ?? "IT Department");
    workLocationController = TextEditingController(
        text: box.read("workLocation") ?? "Hanoi Office");
  }

  /// Bật / tắt chế độ edit
  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }

  /// Lưu dữ liệu
  void saveData() {
    box.write("jobTitle", jobTitleController.text);
    box.write("department", departmentController.text);
    box.write("workLocation", workLocationController.text);
    isEditing.value = false; // thoát chế độ edit sau khi lưu
  }

  /// Huỷ chỉnh sửa
  void cancelEdit() {
    jobTitleController.text = box.read("jobTitle") ?? "Software Engineer";
    departmentController.text = box.read("department") ?? "IT Department";
    workLocationController.text = box.read("workLocation") ?? "Hanoi Office";
    isEditing.value = false;
  }

  @override
  void onClose() {
    jobTitleController.dispose();
    departmentController.dispose();
    workLocationController.dispose();
    super.onClose();
  }
}
