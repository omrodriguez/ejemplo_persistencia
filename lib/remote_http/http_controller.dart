import 'dart:async';
import 'dart:convert';
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
    final response = await http.get(Uri.parse(dataURL));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al recuperar todos');
    }
  }
}