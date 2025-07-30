import 'package:dio/dio.dart';
import 'package:erp_app_nood/api/auth_service.dart';
import 'package:erp_app_nood/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/model/response/auth_respon.dart';


class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final showPassword = false.obs;
  final rememberMe = false.obs;

  final AuthService _authService = AuthService();

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  void login() async {
    try {
      final username = usernameController.text.trim();
      final password = passwordController.text;

      if (username.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'Username or password is empty');
        return;
      }

      final response = await _authService.login(
        username: username,
        password: password,
        rememberMe: rememberMe.value,
      );

      // Lưu token, user info ở đây nếu cần
    

      // Navigate to home screen
      Get.offAllNamed(AppRoutes.home); // nhớ định nghĩa AppRoutes.home

    } catch (e) {
      print("Login error: $e");

      if (e is DioException) {
        final msg = e.response?.data['message'] ?? 'Login failed';
        Get.snackbar('Login Failed', msg.toString());
      } else {
        Get.snackbar('Error', e.toString());
      }
    }
  }

  void forgotPassword() async {
    try {
      final email = usernameController.text.trim(); // hoặc mở dialog nhập email

      if (!GetUtils.isEmail(email)) {
        Get.snackbar("Invalid Email", "Please enter a valid email.");
        return;
      }

      await _authService.forgotPassword(email);

      Get.snackbar("Success", "Password reset email sent.");
    } catch (e) {
      print("Forgot password error: $e");

      if (e is DioException) {
        final msg = e.response?.data['message'] ?? 'Error';
        Get.snackbar('Forgot Password Failed', msg.toString());
      } else {
        Get.snackbar('Error', e.toString());
      }
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
