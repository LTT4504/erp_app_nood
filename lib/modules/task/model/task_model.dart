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
}
