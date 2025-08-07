import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../shared/services/token_storage.dart';
import '../../routes/routes.dart';
import '../../shared/constants/colors.dart';
import 'widgets/showLanguageDialog.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  Future<void> _logout() async {
    await TokenStorage.logout();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.highlightPrimaryPastel,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 24), // ✅ Dịch toàn bộ xuống
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              // ✅ Thông tin user
              Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: ColorConstants.highlightPrimary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.highlightPrimary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: ColorConstants.white,
                    backgroundImage:
                        AssetImage('assets/images/avatar_default.png'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'full_name'.tr,
                    style: const TextStyle(
                      color: ColorConstants.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/ic_briefcase_solid.svg',
                        width: 16,
                        height: 16,
                        colorFilter: const ColorFilter.mode(
                            ColorConstants.white, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${'employee_id'.tr} : N/A',
                        style: const TextStyle(
                          color: ColorConstants.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Danh sách tùy chọn
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.black.withOpacity(0.08),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/svg/ic_language_exchange.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                          ColorConstants.darkGray, BlendMode.srcIn),
                    ),
                    title: Text('language'.tr),
                    onTap: () => showLanguageDialog(context),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/svg/brush.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                          ColorConstants.darkGray, BlendMode.srcIn),
                    ),
                    title: Text('dark_mode'.tr),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/svg/ic_interrogation.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                          ColorConstants.darkGray, BlendMode.srcIn),
                    ),
                    title: Text('support_center'.tr),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/svg/ic_info.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                          ColorConstants.darkGray, BlendMode.srcIn),
                    ),
                    title: Text('about_us'.tr),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Nút đăng xuất
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.black.withOpacity(0.08),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: InkWell(
                onTap: _logout,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: ColorConstants.red,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/ic_exit.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                            ColorConstants.white, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'logout'.tr,
                        style: const TextStyle(
                          color: ColorConstants.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )
    ); 
  }
}
