import 'package:flutter/material.dart';
import 'package:my_requests/models/todo.dart';
import 'package:my_requests/services/add_todo.dart';
import 'package:my_requests/services/delete_todo.dart';
import 'package:my_requests/services/get_todo.dart';
import 'package:my_requests/services/update_todo.dart';

class TodoProvider with ChangeNotifier {
  late GetTodo _getTodo;
  late AddTodo _addTodo;
  late DeleteTodo _deleteTodo;
  late UpdateTodo _updateTodo;

  TodoProvider() {
    _getTodo = GetTodo();
    _addTodo = AddTodo();
    _deleteTodo = DeleteTodo();
    _updateTodo = UpdateTodo();
  }

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> fetchTodos() async {
    _todos = await _getTodo.getTodos();
  }

  Future<void> addTodo(Todo todo) async {
    await _addTodo.addTodo(todo);
    _todos.add(todo);
    notifyListeners();
  }

  Future<void> removeTodo(String id) async {
    try {
      await _deleteTodo.deleteTodo(id);
      _todos.removeWhere((todo) => todo.id == id);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateTodo(String id, Todo todo) async {
    await _updateTodo.updateTodo(id, todo);
    notifyListeners();
  }

  // String getTodoById() {
  //   var index = '';
  //   _todos.map((e) => index = e.id!);

  //   return index;
  // }
}
