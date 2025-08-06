class Task {
  final String priority; // key: high, medium, easy
  final String title;
  final String project;
  final String status; // key: to_do, in_progress, reviewing

  Task({
    required this.priority,
    required this.title,
    required this.project,
    required this.status,
  });
}
