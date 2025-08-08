import 'package:get/get.dart';
import '../modules/attendance/attendance_history_screen.dart';
import '../modules/my_leave/my_leave_binding.dart';
import '../modules/my_leave/my_leave_screen.dart';
import '../modules/my_task/my_task_screen.dart';
import '../modules/my_task/my_task_binding.dart';
import '../modules/attendance/widgets/attendance.dart';
import '../modules/auth/auth_binding.dart';
import '../modules/auth/auth_view.dart';
import '../modules/home/home.dart';
import '../modules/forgot_password/forgot_password_screen.dart';
import '../modules/forgot_password/forgot_password_binding.dart';
import '../modules/forgot_password/sent_email_success.dart';
import '../modules/intro/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.emailSentSuccess,
      page: () => const SentEmailSuccessScreen(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.attendance,
      page: () => const AttendanceScreen(),
      binding: AttendanceBindings(),
    ),
    GetPage(
      name: AppRoutes.attendanceHistory,
      page: () => const AttendanceHistoryScreen(),
    ),
    // Thêm route cho màn hình MyTask
     GetPage(
      name: AppRoutes.myTask,
      page: () => const MyTaskScreen(),
      binding: MyTaskBinding(),
    ),
    // Thêm route cho màn hình MyLeave
    GetPage(
      name: AppRoutes.myLeave,
      page: () => LeaveScreen(),
      binding: LeaveBinding(),
    ),
  ];
}
