import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/services/token_storage.dart';
import '../../routes/routes.dart';
import '../../shared/widgets/custom_button.dart';

class HomeMenuTab extends StatelessWidget {
  const HomeMenuTab({super.key});

  Future<void> _logout() async {
    await TokenStorage.logout();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text(
          'Cài đặt',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Thông tin cá nhân'),
          onTap: () {
            // TODO
          },
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Đổi mật khẩu'),
          onTap: () {
            // TODO
          },
        ),
        const Divider(height: 48),

        // CustomButton với icon & màu đỏ
        CustomButton(
          label: 'Đăng xuất',
          icon: Icons.logout,
          backgroundColor: Colors.redAccent,
          onPressed: _logout,
        ),
      ],
    );
  }
}
