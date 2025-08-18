import '../../api/api_client.dart';
import '../../api/api_constant.dart';
import '../../models/model/education_model.dart';


class EducationService {
  /// GET education info
  static Future<EducationModel?> getEducationInfo() async {
    try {
      final response = await ApiClient.dio.get(ApiConstant.education);
      if (response.statusCode == 200 && response.data['success'] == true) {
        return EducationModel.fromJson(response.data['data']);
      }
    } catch (e) {
      print("Error getEducationInfo: $e");
    }
    return null;
  }

  /// POST update education info
  static Future<bool> updateEducationInfo(EducationModel model) async {
    try {
      final response = await ApiClient.dio.post(
        ApiConstant.education,
        data: model.toJson(),
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        return true;
      }
    } catch (e) {
      print("Error updateEducationInfo: $e");
    }
    return false;
  }
}
