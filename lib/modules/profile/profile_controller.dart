import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Dữ liệu profile giả
  final name = '--'.obs;
  final email = '--'.obs;
  final username = '--'.obs;
  final dob = '--'.obs;
  final phone = '--'.obs;

  @override
  void onInit() {
    super.onInit();
    // Giả lập load data
    fetchProfile();
  }

  void fetchProfile() {
    // Sau này thay bằng API call
    name.value = "Nguyễn Văn A";
    email.value = "example@email.com";
    username.value = "nguyenvana";
    dob.value = "01/01/1990";
    phone.value = "0123456789";
  }
}
