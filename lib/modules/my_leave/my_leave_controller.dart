import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import '../../lang/app_language_key.dart';
import 'model/leave_model.dart';

class LeaveController extends GetxController {
  final _storage = GetStorage();
  final String _storageKey = 'leave_requests';
  final RxList<LeaveModel> leaveRequests = <LeaveModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFromStorage();
  }

  void loadFromStorage() {
    final data = _storage.read<List>(_storageKey);
    if (data != null && data.isNotEmpty) {
      leaveRequests.value = data.map((e) => LeaveModel.fromJson(Map<String, dynamic>.from(e))).toList();
    } else {
      loadSampleData();
      saveToStorage();
    }
  }

  void saveToStorage() {
    _storage.write(_storageKey, leaveRequests.map((e) => e.toJson()).toList());
  }

  void loadSampleData() {
    leaveRequests.value = [
      LeaveModel(
        title: AppLanguageKey.annualLeave,
        date: '25/03/2025 - 25/03/2025',
        status: AppLanguageKey.cancel,
        statusColor: Colors.grey.value,
        reason: AppLanguageKey.personalReasons,
        days: '1 ${AppLanguageKey.days.tr}',
      ),
      // Thêm các mẫu khác...
    ];
  }

  void addLeave(LeaveModel leave) {
    leaveRequests.add(leave);
    saveToStorage();
  }

  void updateLeave(int index, LeaveModel updatedLeave) {
    if (index >= 0 && index < leaveRequests.length) {
      leaveRequests[index] = updatedLeave;
      leaveRequests.refresh();
      saveToStorage();
    }
  }

  void deleteLeave(int index) {
    if (index >= 0 && index < leaveRequests.length) {
      leaveRequests.removeAt(index);
      saveToStorage();
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case AppLanguageKey.newLeave:
        return Colors.blue;
      case AppLanguageKey.waiting:
        return Colors.orange;
      case AppLanguageKey.approved:
        return Colors.green;
      case AppLanguageKey.refuse:
        return Colors.red;
      case AppLanguageKey.cancel:
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}
