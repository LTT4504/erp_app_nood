import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/services/token_storage.dart';
import '../../routes/routes.dart';

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
            
          },
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Đổi mật khẩu'),
          onTap: () {
            
          },
        ),
        const Divider(height: 48),
        ElevatedButton.icon(
          onPressed: _logout,
          icon: const Icon(Icons.logout),
          label: const Text('Đăng xuất'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ],
    );
  }
}
