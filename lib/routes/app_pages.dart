import 'package:get/get.dart';
import 'package:work_manager/modules/profile/bank_salary/bank_salary_binding.dart';
import 'package:work_manager/modules/profile/bank_salary/bank_salary_screen.dart';
import '../modules/annual_calendar/annual_calendar_binding.dart';
import '../modules/annual_calendar/annual_calendar_screen.dart';
import '../modules/attendance/attendance_history_screen.dart';
import '../modules/my project/project_binding.dart';
import '../modules/my project/project_screen.dart';
import '../modules/my project/widgets/project_detail_binding.dart';
import '../modules/my project/widgets/project_detail_screen.dart';
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
import '../modules/notification/notification_binding.dart';
import '../modules/notification/notification_screen.dart';
import '../modules/profile/emergency_contact/emergency_contact_binding.dart';
import '../modules/profile/emergency_contact/emergency_contact_screen.dart';
import '../modules/profile/general_information/general_information_binding.dart';
import '../modules/profile/general_information/general_information_screen.dart';
import '../modules/profile/position/position_binding.dart';
import '../modules/profile/position/position_screen.dart';
import '../modules/profile/profile_binding.dart';
import '../modules/profile/profile_screen.dart';
import '../modules/profile/education/education_binding.dart';
import '../modules/profile/education/education_screen.dart';
import '../modules/task_detail/task_detail_binding.dart';
import '../modules/task_detail/task_detail_screen.dart';
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
      page: () => MyTaskScreen(),
      binding: MyTaskBinding(),
    ),
    // Thêm route cho màn hình MyLeave
    GetPage(
      name: AppRoutes.myLeave,
      page: () => LeaveScreen(),
      binding: LeaveBinding(),
    ),
    // Thêm route cho màn hình AnnualCalendar
    GetPage(
      name: AppRoutes.annualCalendar,
      page: () => const AnnualCalendarScreen(),
      binding: AnnualCalendarBinding(),
    ),
    // Thêm route cho màn hình PersonalNotifications
    GetPage(
      name: AppRoutes.personalNotifications,
      page: () => const PersonalNotificationsScreen(),
      binding: PersonalNotificationsBinding(),
    ),
    GetPage(
      name: AppRoutes.taskDetail,
      page: () => const TaskDetailScreen(),
      binding: TaskDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),

    GetPage(
      name: AppRoutes.education,
      page: () => const EducationScreen(),
      binding: EducationBinding(),
    ),
    GetPage(
      name: AppRoutes.myTask,
      page: () => MyTaskScreen(),
      binding: MyTaskBinding(),
    ),
    GetPage(
      name: AppRoutes.generalInfo,
      page: () => const GeneralInformationScreen(),
      binding: GeneralInformationBinding(),
    ),
    GetPage(
      name: AppRoutes.position,
      page: () => const PositionScreen(),
      binding: PositionBinding(),
    ),
    GetPage(
      name: AppRoutes.bankSalary,
      page: () => const BankSalaryScreen(),
      binding: BankSalaryBinding(),
    ),
    GetPage(
      name: AppRoutes.emergencyContact,
      page: () => const EmergencyContactScreen(),
      binding: EmergencyContactBinding(),
    ),
    GetPage(
      name: AppRoutes.myProject,
      page: () => const ProjectScreen(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: AppRoutes.projectDetail,
      page: () => const ProjectDetailScreen(),
      binding: ProjectDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.taskDetail,
      page: () => const TaskDetailScreen(),
      binding: TaskDetailBinding(),
    ),
  ];
}
