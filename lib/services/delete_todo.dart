import 'package:http/http.dart' as http;
import 'package:my_requests/constants/services_constants.dart';

class DeleteTodo {
  String baseUrl = Constants.baseUrl;

  Future<void> deleteTodo(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to delete Todo');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
