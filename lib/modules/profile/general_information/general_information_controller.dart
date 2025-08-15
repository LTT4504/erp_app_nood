import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../../api/api_constant.dart';
import '../../../shared/services/token_storage.dart';

class GeneralInformationController extends GetxController {
  // --- Trạng thái ---
  final isLoading = false.obs;
  final isEditing = false.obs;

  // --- Observables gốc ---
  final fullName = ''.obs;
  final nickName = ''.obs;
  final birthday = ''.obs;
  final gender = ''.obs;
  final phoneNumber = ''.obs;
  final idNumber = ''.obs;
  final provideDate = ''.obs;
  final providePlace = ''.obs;
  final maritalStatus = ''.obs;
  final numberOfChildren = 0.obs;
  final placeOfBirth = ''.obs;
  final address = ''.obs;

  // --- Controllers cho form ---
  late TextEditingController fullNameController;
  late TextEditingController nickNameController;
  late TextEditingController birthdayController;
  late TextEditingController genderController;
  late TextEditingController phoneNumberController;
  late TextEditingController idNumberController;
  late TextEditingController provideDateController;
  late TextEditingController providePlaceController;
  late TextEditingController maritalStatusController;
  late TextEditingController numberOfChildrenController;
  late TextEditingController placeOfBirthController;
  late TextEditingController addressController;

  // --- Networking ---
  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    _initControllers();
    fetchUserInfo();
  }

  void _initControllers() {
    fullNameController = TextEditingController();
    nickNameController = TextEditingController();
    birthdayController = TextEditingController();
    genderController = TextEditingController();
    phoneNumberController = TextEditingController();
    idNumberController = TextEditingController();
    provideDateController = TextEditingController();
    providePlaceController = TextEditingController();
    maritalStatusController = TextEditingController();
    numberOfChildrenController = TextEditingController();
    placeOfBirthController = TextEditingController();
    addressController = TextEditingController();
  }

  /// Lấy thông tin người dùng từ API
  Future<void> fetchUserInfo() async {
    isLoading.value = true;
    try {
      final token = await TokenStorage.getAccessToken();
      if (token == null || token.isEmpty) {
        Get.snackbar('Lỗi', 'Không tìm thấy access token. Vui lòng đăng nhập lại.');
        return;
      }

      final response = await _dio.get(
        '${ApiConstant.baseUrl}/api/user/me',
        options: Options(
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final data = response.data['data'];

        // Gán vào observable
        fullName.value = data['fullName'] ?? '';
        nickName.value = data['nickName'] ?? '';
        birthday.value = data['birthday'] ?? '';
        gender.value = data['gender']?.toString() ?? '';
        phoneNumber.value = data['phoneNo'] ?? '';
        idNumber.value = data['identityCard'] ?? '';
        provideDate.value = data['provideDateIdentityCard'] ?? '';
        providePlace.value = data['providePlaceIdentityCard'] ?? '';
        maritalStatus.value = data['maritalStatus']?.toString() ?? '';
        numberOfChildren.value = data['numberChild'] ?? 0;
        placeOfBirth.value = data['placeOfBirth'] ?? '';
        address.value = data['address'] ?? '';

        // Gán vào controller form
        fullNameController.text = fullName.value;
        nickNameController.text = nickName.value;
        birthdayController.text = birthday.value;
        genderController.text = gender.value;
        phoneNumberController.text = phoneNumber.value;
        idNumberController.text = idNumber.value;
        provideDateController.text = provideDate.value;
        providePlaceController.text = providePlace.value;
        maritalStatusController.text = maritalStatus.value;
        numberOfChildrenController.text = numberOfChildren.value.toString();
        placeOfBirthController.text = placeOfBirth.value;
        addressController.text = address.value;
      } else {
        Get.snackbar('Lỗi', 'Không lấy được thông tin người dùng.');
      }
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã xảy ra lỗi: ${e is DioError ? e.message : e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Bật chế độ chỉnh sửa
  void enableEditing() {
    isEditing.value = true;
  }

  /// Hủy chỉnh sửa
  void cancelEditing() {
    isEditing.value = false;
    // Reset lại dữ liệu form về như ban đầu
    fullNameController.text = fullName.value;
    nickNameController.text = nickName.value;
    birthdayController.text = birthday.value;
    genderController.text = gender.value;
    phoneNumberController.text = phoneNumber.value;
    idNumberController.text = idNumber.value;
    provideDateController.text = provideDate.value;
    providePlaceController.text = providePlace.value;
    maritalStatusController.text = maritalStatus.value;
    numberOfChildrenController.text = numberOfChildren.value.toString();
    placeOfBirthController.text = placeOfBirth.value;
    addressController.text = address.value;
  }

  /// Lưu thông tin mới lên API
  Future<void> updateUserInfo() async {
    try {
      final token = await TokenStorage.getAccessToken();
      if (token == null || token.isEmpty) {
        Get.snackbar('Lỗi', 'Không tìm thấy access token.');
        return;
      }

      final body = {
        'fullName': fullNameController.text,
        'nickName': nickNameController.text,
        'birthday': birthdayController.text,
        'gender': genderController.text,
        'phoneNo': phoneNumberController.text,
        'identityCard': idNumberController.text,
        'provideDateIdentityCard': provideDateController.text,
        'providePlaceIdentityCard': providePlaceController.text,
        'maritalStatus': maritalStatusController.text,
        'numberChild': int.tryParse(numberOfChildrenController.text) ?? 0,
        'placeOfBirth': placeOfBirthController.text,
        'address': addressController.text,
      };

      final response = await _dio.put(
        '${ApiConstant.baseUrl}/api/user/me',
        data: body,
        options: Options(
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Thành công', 'Cập nhật thông tin thành công.');
        isEditing.value = false;
        await fetchUserInfo(); // Load lại dữ liệu mới
      } else {
        Get.snackbar('Lỗi', 'Cập nhật thất bại.');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Đã xảy ra lỗi: ${e.toString()}');
    }
  }
}
