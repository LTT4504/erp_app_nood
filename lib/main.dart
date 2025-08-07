import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart'; 
import 'lang/generate/translation_service.dart';
import 'modules/auth/auth_binding.dart';
import 'routes/routes.dart';
import 'shared/controller/locate_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init(); 
  await initializeDateFormatting(); 

  Get.put(LocaleController()); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: TranslationService(),
      locale: Get.find<LocaleController>().getLocale(), 
      fallbackLocale: const Locale('en', 'US'),
      title: 'Nine Plus',
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}
