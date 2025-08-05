import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../shared/services/auth_service.dart';
import '../../routes/routes.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  Future<void> sendResetEmail() async {
    final email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      Get.snackbar('Error', 'Please enter a valid email.');
      return;
    }

    isLoading.value = true;
    try {
      await AuthService().forgotPassword(email);
      Get.toNamed(AppRoutes.emailSentSuccess);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        Get.snackbar('Error', 'Email does not exist.');
      } else {
        Get.snackbar('Error', 'Something went wrong. Please try again.');
      }
    } catch (_) {
      Get.snackbar('Error', 'Unexpected error occurred.');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose(); // dispose đúng cách
    super.onClose();
  }
}
