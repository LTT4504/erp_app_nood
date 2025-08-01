import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/auth_service.dart';
import '../../routes/routes.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  Future<void> sendResetEmail() async {
    final email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      Get.snackbar('Lỗi', 'Vui lòng nhập email hợp lệ');
      return;
    }

    isLoading.value = true;
    try {
      await AuthService().forgotPassword(email);
      Get.offNamed(AppRoutes.emailSentSuccess);
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
