import 'package:flutter/material.dart';
import 'package:my_requests/models/todo.dart';
import 'package:my_requests/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({this.todo, super.key});

  final Todo? todo;

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();

  bool _statusController = false;
  var status = [true, false];

  bool isEditing = false;

  @override
  void initState() {
    if (widget.todo == null) {
      return;
    }
    isEditing = widget.todo != null;
    _titleController = TextEditingController(text: widget.todo!.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Update Todo' : 'Add Todo'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _titleController,
                ),
                DropdownButtonFormField(
                  value: isEditing ? widget.todo!.completed : false,
                  items: [
                    ...status.map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(item.toString()),
                      ),
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        return;
                      }
                      _statusController = value;
                    });
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      isEditing
                          ? todoProvider.updateTodo(
                              widget.todo!.id!,
                              Todo(
                                title: _titleController.text,
                                completed: _statusController,
                              ),
                            )
                          : todoProvider.addTodo(
                              Todo(
                                title: _titleController.text,
                                completed: _statusController,
                              ),
                            );
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  child: Text(isEditing ? 'Update' : 'Add Todo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
