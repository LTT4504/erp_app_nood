import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/shared.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_form_field.dart';
import 'auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                AssetPath.iconNinePlus,
                height: 300,
              ),

              // Login Card
              Container(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Please log in to continue.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Username
                      CustomTextFormField(
                        label: "Username",
                        hint: "Enter your username",
                        icon: Icons.person,
                        primaryColor: ColorConstants.highlightPrimary,
                        controller: controller.usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password
                      Obx(
                        () => CustomTextFormField(
                          label: "Password",
                          hint: "Enter your password",
                          icon: Icons.lock,
                          primaryColor: ColorConstants.highlightPrimary,
                          controller: controller.passwordController,
                          obscureText: !controller.showPassword.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          suffix: IconButton(
                            icon: Icon(
                              controller.showPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: ColorConstants.highlightPrimary,
                            ),
                            onPressed: controller.toggleShowPassword,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Remember me & Forgot password
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.rememberMe.value,
                              activeColor: ColorConstants.highlightPrimary,
                              onChanged: controller.toggleRememberMe,
                            ),
                          ),
                          const Text("Remember me"),
                          const Spacer(),
                          GestureDetector(
                            onTap: controller.forgotPassword,
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: ColorConstants.highlightPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Login Button
                      CustomButton(
                        label: "Login",
                        onPressed: controller.login,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
