import 'package:dio/dio.dart';
import '../../api/api_client.dart';
import '../../api/api_constant.dart';
import '../../models/model/emergency_contact_model.dart';


class EmergencyContactService {
  final Dio _dio = ApiClient.dio;

  Future<EmergencyContact?> fetchContact() async {
    try {
      final response = await _dio.get(ApiConstant.emergencyContact);
      return EmergencyContact.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveContact(EmergencyContact contact) async {
    try {
      await _dio.post(
        ApiConstant.emergencyContact,
        data: contact.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
