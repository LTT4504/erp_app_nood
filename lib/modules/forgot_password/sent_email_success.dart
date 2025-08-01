import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../shared/shared.dart';
import '../../shared/widgets/custom_button.dart';

class SentEmailSuccessScreen extends StatelessWidget {
  const SentEmailSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        title: const Text('Success'),
        backgroundColor: ColorConstants.highlightPrimary,
        foregroundColor: ColorConstants.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.email_outlined, size: 100, color: ColorConstants.highlightPrimary),
              const SizedBox(height: 16),
              const Text(
                'A reset email has been sent. Please check your inbox.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              CustomButton(
                label: 'Back to Login',
                onPressed: () {
                  // Cách 1: không delete để controller còn dùng nếu quay lại
                  Get.offAllNamed(AppRoutes.login);
                  
                  // Cách 2: nếu muốn xoá thì phải đảm bảo không tái sử dụng
                  // Get.delete<ForgotPasswordController>();
                  // Get.offAllNamed(AppRoutes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
