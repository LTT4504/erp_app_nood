import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/constants/colors.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/services/token_storage.dart';
import '../../routes/routes.dart';
import '../../lang/app_language_key.dart';
import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      appBar: AppBar(
        backgroundColor: ColorConstants.highlightPrimary,
        elevation: 0,
        title: Text(
          AppLanguageKey.profile.tr,
          style: const TextStyle(
            color: ColorConstants.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorConstants.white),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 32),
          // Avatar + tên + username
          Center(
            child: Column(
              children: [
                const Stack(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: ColorConstants.white,
                      child: Icon(Icons.person,
                          size: 50, color: ColorConstants.highlightPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Obx(() => Text(
                      controller.name.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ColorConstants.highlightPrimary,
                      ),
                    )),
                Obx(() => Text(
                      controller.username.value,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // _buildMenuItem(
          //     Icons.person_outline, AppLanguageKey.generalInformation.tr),
          // _buildMenuItem(
          //     Icons.phone_android, AppLanguageKey.emergencyContact.tr),
          _buildMenuItem(
            Icons.school_outlined,
            AppLanguageKey.education.tr,
            onTap: () => Get.toNamed(AppRoutes.education),
          ),
          // _buildMenuItem(Icons.work_outline, AppLanguageKey.position.tr),
          // _buildMenuItem(Icons.account_balance_outlined,
          //     AppLanguageKey.bankAndSalary.tr),

          const SizedBox(height: 20),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    String? badge,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: ColorConstants.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:
            const BorderSide(color: ColorConstants.highlightPrimary, width: 1),
      ),
      elevation: 0.5,
      child: ListTile(
        leading: Icon(icon, color: ColorConstants.highlightPrimary),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: ColorConstants.highlightSecondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: ColorConstants.white,
                    fontSize: 12,
                  ),
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CustomButton(
        label: AppLanguageKey.logout.tr,
        icon: Icons.logout,
        backgroundColor: ColorConstants.red,
        onPressed: () async {
          await TokenStorage.logout();
          Get.offAllNamed(AppRoutes.login);
        },
      ),
    );
  }
}
