class Task {
  final int id;
  final String title;
  final String description;
  final String status;
  final String dueDate; // Campo de data de vencimento
  final DateTime createdAt; // Usando DateTime para campos de data/hora
  final DateTime updatedAt;
  final int userId;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      dueDate: json['due_date'] as String,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      userId: json['user_id'] as int,
    );
  }
}
