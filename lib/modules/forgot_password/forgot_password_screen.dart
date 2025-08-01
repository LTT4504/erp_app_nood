import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/shared.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_form_field.dart';
import 'forgot_password_controler.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: ColorConstants.highlightPrimary,
        foregroundColor: ColorConstants.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your email to receive a password reset link.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Email',
              hint: 'example@email.com',
              icon: Icons.email_outlined,
              primaryColor: ColorConstants.highlightPrimary,
              controller: controller.emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!GetUtils.isEmail(value)) {
                  return 'Invalid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Obx(() => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    label: 'Send Email',
                    onPressed: controller.sendResetEmail,
                  )),
          ],
        ),
      ),
    );
  }
}
