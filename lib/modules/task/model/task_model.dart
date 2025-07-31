class Task {
  final String priority; // High, Medium, Easy
  final String title;
  final String project;
  final String status;   // To Do, In Progress, Reviewing

  Task({
    required this.priority,
    required this.title,
    required this.project,
    required this.status,
  });

  String get priorityLabel {
    switch (priority) {
      case 'High':
        return 'Cao';
      case 'Medium':
        return 'Trung bình';
      case 'Easy':
        return 'Thấp';
      default:
        return priority;
    }
  }

  String get statusLabel {
    switch (status) {
      case 'To Do':
        return 'Cần làm';
      case 'In Progress':
        return 'Trong tiến trình';
      case 'Reviewing':
        return 'Đang review';
      default:
        return status;
    }
  }
}
