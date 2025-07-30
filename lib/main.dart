import 'package:erp_app_nood/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'modules/auth/auth_binding.dart';
import 'modules/auth/auth_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Quan trọng!
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nine Plus',
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      home: const AuthView(),
      getPages: AppPages.routes,
    );
  }
}
