import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../shared/services/auth_service.dart';
import '../../routes/routes.dart';
import '../../shared/services/token_storage.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;

  final showPassword = false.obs;
  final rememberMe = false.obs;

  final AuthService _authService = AuthService();
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();

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

  void toggleShowPassword() => showPassword.toggle();

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
    storage.write('rememberMe', rememberMe.value);
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    final username = usernameController.text.trim();
    final password = passwordController.text;

    try {
      final response = await _authService.login(
        username: username,
        password: password,
        rememberMe: rememberMe.value,
      );

      // ✅ Chỉ điều hướng khi login thành công thật sự
      if (response.status == 200 && response.success == true) {
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
        // ❌ Lỗi đăng nhập (API trả lỗi hoặc success = false)
        final msg = response.message.isNotEmpty
            ? response.message
            : 'Sai tài khoản hoặc mật khẩu';
        Get.snackbar('Lỗi đăng nhập', msg);
      }
    } catch (e) {
      if (e is DioException) {
        var msg = 'Đăng nhập thất bại';
        final statusCode = e.response?.statusCode;
        if (e.response?.data?['message'] != null) {
          msg = e.response?.data['message'] as String;
        } else if (statusCode == 401) {
          msg = 'Sai tài khoản hoặc mật khẩu';
        }
        Get.snackbar('Lỗi đăng nhập', msg);
      } else {
        Get.snackbar(
          'Lỗi hệ thống',
          'Có lỗi xảy ra, vui lòng thử lại sau.',
        );
      }
    }
  }

  void forgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  Future<void> logout() async {
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
