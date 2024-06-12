class Todo {
  Todo({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  final int? userId;
  final String? id;
  final String? title;
  final bool? completed;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'] ?? 0,
      id: json['_id'] ?? 0,
      title: json['title'] ?? "",
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'completed': completed,
      };
}
