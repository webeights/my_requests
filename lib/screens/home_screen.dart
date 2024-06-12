import 'package:flutter/material.dart';
import 'package:my_requests/providers/todo_provider.dart';
import 'package:my_requests/screens/create_todo.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoListProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateTodo(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Todo'),
      ),
      body: FutureBuilder(
        future: todoListProvider.fetchTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load Data: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: todoListProvider.todos.length,
              itemBuilder: (context, index) {
                final todo = todoListProvider.todos[index];
                return ListTile(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateTodo(todo: todo)));
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  title: Text(todo.title!),
                  trailing: IconButton(
                    onPressed: () {
                      todoListProvider.removeTodo(todo.id!);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
