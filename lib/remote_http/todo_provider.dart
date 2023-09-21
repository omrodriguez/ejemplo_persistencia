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

  Future<void> agregarTodo(String titulo) async {
    Todo todo = await httpController.agregarTodo(titulo);
    _todos.add(todo);
    notifyListeners();
  }

  Future<void> actualizarTodo(Todo todo) async {
    todo = await httpController.actualizarTodo(todo);
    notifyListeners();
  }

  Future<void> eliminarTodo(Todo todo) async {
    bool eliminado = await httpController.eliminarTodo(todo);
    if (eliminado) {
      _todos.remove(todo);
      notifyListeners();
    }
  }

  Todo getTodoByIndex(int index) =>_todos[index];
}