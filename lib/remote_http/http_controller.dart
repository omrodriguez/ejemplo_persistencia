import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'todo.dart';

class HttpController {
  static const String dataURL = "https://jsonplaceholder.typicode.com/todos";

  Future<Todo> getTodoByIndex(int index) async {
    final response = await http.get(Uri.parse('$dataURL/$index'));

    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al recuperar todo[$index]');
    }
  }

  Future<List<dynamic>> getTodos() async {
    final response = await http.get(Uri.parse(dataURL),
    headers: {
      HttpHeaders.authorizationHeader: "token_de_seguridad_del_API",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al recuperar todos');
    }
  }

  Future<Todo> agregarTodo(String titulo) async{
    final res = await http.post(Uri.parse(dataURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title' : titulo,
      }),
    );

    if (res.statusCode == 201) {
      return Todo.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Error al agregar todo: $titulo');
    }
  }

  Future<Todo> actualizarTodo(Todo todo) async {
    final res = await http.put(Uri.parse('$dataURL/${todo.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(todo.toJson()),
    );

    if (res.statusCode == 200) {
      return Todo.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Error al actualizar todo: $todo');
    }
  }

  Future<bool> eliminarTodo(Todo todo) async {
    final res = await http.delete(Uri.parse('$dataURL/${todo.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}