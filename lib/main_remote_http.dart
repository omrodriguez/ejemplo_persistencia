import 'remote_http/views/todos_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'remote_http/modelo/todo_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(create: (_) =>
    TodoProvider(),
    child: const MyApp()
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodosLista(),
    );
  }
}

