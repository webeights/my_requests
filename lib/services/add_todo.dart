import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_requests/constants/services_constants.dart';
import 'package:my_requests/models/todo.dart';

class AddTodo {
  String baseUrl = Constants.baseUrl;

  Future addTodo(Todo todo) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': todo.title,
          'complete': todo.completed,
        }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return Todo.fromJson(responseData);
      } else {
        throw Exception('Failed to add todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
