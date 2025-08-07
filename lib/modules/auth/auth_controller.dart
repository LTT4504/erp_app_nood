import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../shared/services/auth_service.dart';
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
    try {
      rememberMe.value = TokenStorage.getRememberMe();
      if (rememberMe.value) {
        usernameController.text = TokenStorage.getSavedUsername() ?? '';
        passwordController.text = TokenStorage.getSavedPassword() ?? '';
      }
    } catch (e) {
      debugPrint('Storage read error: $e');
      rememberMe.value = false;
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
    if (!formKey.currentState!.validate()) return;

    final username = usernameController.text.trim();
    final password = passwordController.text;
    try {
      final response = await _authService.login(
        username: username,
        password: password,
        rememberMe: rememberMe.value,
      );
      if ([400, 401, 403, 404].contains(response.status)) {
        String msg = response.message.isNotEmpty ? response.message : 'Sai tài khoản hoặc mật khẩu';
        Get.snackbar('Lỗiiiii đăng nhập', msg);
      } else if (response.status == 200 && response.success == true) {
        await TokenStorage.saveAccessToken(response.data.accessToken);
        await TokenStorage.saveRefreshToken(response.data.refreshToken);

        if (rememberMe.value) {
          await storage.write('username', username);
          await storage.write('password', password);
        } else {
          await storage.remove('username');
          await storage.remove('password');
        }

        Get.offAllNamed(AppRoutes.home);
      } else {
        String msg = response.message.isNotEmpty ? response.message : 'Đăng nhập thất bại';
        Get.snackbar('Lỗiaaa đăng nhập', msg);
      }
    } catch (e) {
      if (e is DioException) {
        String msg = e.response?.data['message']?.toString() ?? 'Sai tài khoản hoặc mật khẩu';
        Get.snackbar('Lỗi000000 đăng nhập', msg);
      } else {
        Get.snackbar('Lỗi hệ thống', 'Có lỗi xảy ra, vui lòng thử lại sau.');
      }
    }
  }

  void forgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  void logout() async {
    await TokenStorage.logout();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
