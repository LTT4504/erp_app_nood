import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../shared/services/token_storage.dart';
import '../../routes/routes.dart';
import '../../shared/constants/colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  Future<void> _logout() async {
    await TokenStorage.logout();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        // Thông tin user
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ColorConstants.highlightPrimary,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.highlightPrimary.withOpacity(0.3),
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
                backgroundImage: AssetImage('assets/images/avatar_default.png'),
              ),
              const SizedBox(height: 8),
              const Text(
                'Full Name',
                style: TextStyle(color: ColorConstants.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/ic_briefcase_solid.svg',
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(ColorConstants.white, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 4),
                  const Text('Employee ID :  N/A',
                      style: TextStyle(color: ColorConstants.white, fontSize: 13)),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Danh sách tùy chọn
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
                  colorFilter: const ColorFilter.mode(ColorConstants.darkGray, BlendMode.srcIn),
                ),
                title: const Text('Ngôn ngữ'),
                trailing: SvgPicture.asset(
                  'assets/svg/vi.svg',
                  width: 24,
                  height: 24,
                ),
                onTap: () {},
              ),
              const Divider(height: 1),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/brush.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(ColorConstants.darkGray, BlendMode.srcIn),
                ),
                title: const Text('Giao diện tối'),
                trailing: const Icon(Icons.settings, color: ColorConstants.darkGray),
                onTap: () {},
              ),
              const Divider(height: 1),
               ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/ic_interrogation.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(ColorConstants.darkGray, BlendMode.srcIn),
                ),
                title: const Text('Trung tâm hỗ trợ'),
                onTap: () {},
              ),
              const Divider(height: 1),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/ic_info.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(ColorConstants.darkGray, BlendMode.srcIn),
                ),
                title: const Text('Về chúng tôi'),
                onTap: () {},
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
        
        // Nút đăng xuất
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
                    colorFilter: const ColorFilter.mode(ColorConstants.white, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Đăng xuất',
                    style: TextStyle(
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
    );
  }
}
