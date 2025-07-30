import 'package:get/get.dart';
import '../../modules/home/home.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    // Thêm các GetPage khác tại đây
  ];
}
