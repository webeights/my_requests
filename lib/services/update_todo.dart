import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_requests/constants/services_constants.dart';
import 'package:my_requests/models/todo.dart';

class UpdateTodo {
  String baseUrl = Constants.baseUrl;

  Future<void> updateTodo(String id, Todo todo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        Todo(id: id, title: todo.title, completed: todo.completed),
      ),
    );

    if (response.statusCode == 200) {
      print('from IF: ${response.statusCode}');
      print('SUCCESS!');
    } else {
      print('from ELSE: ${response.statusCode}');
      throw Exception('Failed to update todo item: ${response.reasonPhrase}');
    }
  }
}
