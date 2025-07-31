import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../api/auth_service.dart';
import '../../routes/routes.dart';
import '../../shared/services/token_storage.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final showPassword = false.obs;
  final rememberMe = false.obs;

  final AuthService _authService = AuthService();
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();

    // Load rememberMe flag
    rememberMe.value = storage.read('rememberMe') ?? false;

    // Nếu rememberMe = true thì tự điền lại thông tin
    if (rememberMe.value) {
      usernameController.text = storage.read('username') ?? '';
      passwordController.text = storage.read('password') ?? '';
    }
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
    storage.write('rememberMe', rememberMe.value); // Ghi đè ngay khi thay đổi
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

      await TokenStorage.saveAccessToken(response.data.accessToken);
      await TokenStorage.saveRefreshToken(response.data.refreshToken);

      // ✅ Lưu thông tin nếu có rememberMe
      if (rememberMe.value) {
        await storage.write('username', username);
        await storage.write('password', password);
      } else {
        await storage.remove('username');
        await storage.remove('password');
      }

      // Chuyển sang màn hình chính
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      if (e is DioException) {
        final msg = e.response?.data['message'] ?? 'Login failed';
        Get.snackbar('Login Failed', msg.toString());
      } else {
        Get.snackbar('Error', e.toString());
      }
    }
  }

  void forgotPassword() async {
    final email = usernameController.text.trim();

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email.");
      return;
    }

    try {
      await _authService.forgotPassword(email);
      Get.snackbar("Success", "Password reset email sent.");
    } catch (e) {
      final msg = (e is DioException) ? e.response?.data['message'] : e.toString();
      Get.snackbar('Forgot Password Failed', msg.toString());
    }
  }

  void logout() async {
    await TokenStorage.logout(); // gọi logout logic có check rememberMe
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
