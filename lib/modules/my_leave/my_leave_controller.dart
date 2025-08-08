import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LeaveController extends GetxController {
  var leaveRequests = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSampleData();
  }

  /// ✅ Tải dữ liệu mẫu
  void loadSampleData() {
    leaveRequests.value = [
      {
        "title": "Nghỉ phép thường niên",
        "date": "25/03/2025 - 25/03/2025",
        "status": "Hủy",
        "statusColor": Colors.grey,
        "reason": "Lí do cá nhân",
        "days": "1 ngày"
      },
      {
        "title": "Đi công tác",
        "date": "28/03/2025 - 30/03/2025",
        "status": "Đang chờ",
        "statusColor": Colors.orange,
        "reason": "Đi công tác",
        "days": "3 ngày"
      },
      {
        "title": "Xin phép ra ngoài",
        "date": "25/03/2025 - 25/03/2025",
        "status": "Đã duyệt",
        "statusColor": Colors.green,
        "reason": "Nghỉ ốm vì quá khỏe",
        "days": "1 ngày"
      },
      {
        "title": "Nghỉ hưởng bảo hiểm",
        "date": "25/03/2025 - 25/03/2025",
        "status": "Từ chối",
        "statusColor": Colors.red,
        "reason": "Khám bệnh",
        "days": "1 ngày"
      },
      {
        "title": "Làm từ xa",
        "date": "25/03/2025 - 25/03/2025",
        "status": "Mới",
        "statusColor": Colors.blue,
        "reason": "Dị ứng",
        "days": "1 ngày"
      },
    ];
  }

  /// ✅ Thêm đơn nghỉ phép
  void addLeave(Map<String, dynamic> leave) {
    leaveRequests.add(leave);
  }

  /// ✅ Sửa đơn nghỉ phép
  void updateLeave(int index, Map<String, dynamic> updatedLeave) {
    if (index >= 0 && index < leaveRequests.length) {
      leaveRequests[index] = updatedLeave;
      leaveRequests.refresh();
    }
  }

  /// ✅ Xóa đơn nghỉ phép
  void deleteLeave(int index) {
    if (index >= 0 && index < leaveRequests.length) {
      leaveRequests.removeAt(index);
    }
  }

  /// ✅ Lấy màu theo trạng thái
  Color getStatusColor(String status) {
    switch (status) {
      case "Mới":
        return Colors.blue;
      case "Đang chờ":
        return Colors.orange;
      case "Đã duyệt":
        return Colors.green;
      case "Từ chối":
        return Colors.red;
      case "Hủy":
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}
