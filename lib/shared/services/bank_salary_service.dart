import '../../api/api_client.dart';
import '../../api/api_constant.dart';
import '../../models/model/bank_salary_model.dart';

class BankSalaryService {
  static Future<BankSalaryModel?> getBankSalary() async {
    try {
      final response = await ApiClient.dio.get(ApiConstant.bankSalary);
      if (response.statusCode == 200 && response.data['success'] == true) {
        return BankSalaryModel.fromJson(response.data['data']);
      }
    } catch (e) {
      print("❌ Error fetching bank salary: $e");
    }
    return null;
  }

  static Future<bool> updateBankSalary(BankSalaryModel model) async {
    try {
      final response = await ApiClient.dio.post(
        ApiConstant.bankSalary,
        data: model.toJson(),
      );
      return response.statusCode == 200 && response.data['success'] == true;
    } catch (e) {
      print("❌ Error updating bank salary: $e");
      return false;
    }
  }
}
