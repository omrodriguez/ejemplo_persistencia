import 'package:flutter/material.dart';
import 'todo.dart';
import 'http_controller.dart';

class TodoProvider extends ChangeNotifier {
  static final List<Todo> _todos = [];
  static final HttpController httpController = HttpController();

  TodoProvider();
  
  List<Todo> get todos => _todos;

  static Future<void> inicializarTodos() async {
    List<dynamic> todos;
    try {
      todos = await httpController.getTodos();
       for (int i = 0; i < todos.length; i++) {
        _todos.add(Todo.fromJson(todos[i]));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Todo getTodoByIndex(int index) =>_todos[index];
}