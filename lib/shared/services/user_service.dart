import 'package:work_manager/api/api_client.dart';
import 'package:work_manager/api/api_constant.dart';
import '../../models/model/user_model.dart';

class UserService {
  static Future<UserModel?> getMe() async {
    final response = await ApiClient.dio.get(ApiConstant.userMe);

    if (response.statusCode == 200 && response.data['success'] == true) {
      return UserModel.fromJson(response.data['data']);
    }
    return null;
  }

  static Future<bool> updateMe(UserModel user) async {
    final response = await ApiClient.dio.post(
      ApiConstant.userMe,
      data: user.toUpdateJson(),
    );

    if (response.statusCode == 200 && response.data['success'] == true) {
      return true;
    }
    return false;
  }
}
