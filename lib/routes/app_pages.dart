import 'package:get/get.dart';
import '../modules/auth/auth_view.dart';
import '../modules/home/home.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const AuthView(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
        binding: HomeBinding(),
    ),
    
  ];
}
