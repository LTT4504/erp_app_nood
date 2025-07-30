import 'package:erp_app_nood/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor:ColorConstants.highlightPrimaryPastel,
      body: SafeArea(
  child: SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo
        Image.asset(
          AssetPath.iconNinePlus,
          height: 280,
        ),
        

        // Login Card
        Container(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                // Username
                TextFormField(
                  controller: controller.usernameController,
                  cursorColor: Colors.black,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  decoration: _inputDecoration("Username", "Enter your username", Icons.person, ColorConstants.highlightPrimary),
                ),

                const SizedBox(height: 20),

                // Password
                Obx(() => TextFormField(
                      controller: controller.passwordController,
                      obscureText: !controller.showPassword.value,
                      cursorColor: Colors.black,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      decoration: _inputDecoration(
                        "Password",
                        "Enter your password",
                        Icons.lock,
                        ColorConstants.highlightPrimary,
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
                    )),

                const SizedBox(height: 12),

                // Remember me & Forgot password
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          activeColor: ColorConstants.highlightPrimary, // ✅ tick màu xanh
                          onChanged: (value) => controller.toggleRememberMe(value),
                        )),
                    const Text("Remember me"),
                    const Spacer(),
                    GestureDetector(
                      onTap: controller.forgotPassword,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: ColorConstants.highlightPrimary),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 24),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.login();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.highlightPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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

  InputDecoration _inputDecoration(
    String label,
    String hint,
    IconData icon,
    Color primaryColor, {
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: primaryColor),
      suffixIcon: suffix,
      labelStyle: TextStyle(color: primaryColor),
      hintStyle: TextStyle(color: primaryColor.withOpacity(0.6)),
      filled: true,
      fillColor: ColorConstants.lightGray,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}
