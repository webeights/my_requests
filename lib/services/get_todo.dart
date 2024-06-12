import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_requests/constants/services_constants.dart';
import 'package:my_requests/models/todo.dart';

class GetTodo {
  final List<Todo> todos = [];

  String baseUrl = Constants.baseUrl;

  Future<List<Todo>> getTodos() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((data) => Todo.fromJson(data)).toList();
    } else {
      throw Exception('Failed to get data');
    }
  }
}
