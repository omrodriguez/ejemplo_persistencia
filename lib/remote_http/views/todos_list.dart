import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modelo/todo_provider.dart';
import '../modelo/todo.dart';
import 'todo_form.dart';

class TodosLista extends StatefulWidget {

  const TodosLista({super.key});

  @override
  State<TodosLista> createState() => _TodosListaState();
}

class _TodosListaState extends State<TodosLista> {
  bool cargando = true;
  int selectedTodo = 0;
  late TodoProvider todosProvider;
  
  @override
  void initState() {
    super.initState();
    TodoProvider.inicializarTodos().then((value) => setState(() {
        cargando = false;
    }));}

  @override
  Widget build(BuildContext context) {
    todosProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Cosas por hacer"),
      ),
      body: cargando? const Center(child: CircularProgressIndicator()) 
        : (todosProvider.todos.isNotEmpty)? ListView(
          padding: const EdgeInsets.all(10),
          children: ListTile.divideTiles(context: context, 
            tiles: crearLista(), color:Colors.amber).toList(),
          )
        : Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ElevatedButton(
              onPressed: () { nuevoTodo(context); },
              child: const Text("Agregar Todo"),
            )),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nuevoTodo(context);
        },
        tooltip: 'Nuevo todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> crearLista() {
    final List<Widget> lista = <Widget>[];
    for(int i = 0; i < todosProvider.todos.length; i++ ){
      Todo todo = todosProvider.getTodoByIndex(i);
      lista.add(
        ListTile(
          leading: Checkbox(
            value: todo.completed,
            onChanged: (_) {
              todo.completed = !todo.completed;
              todosProvider.actualizarTodo(todo);
            } ),
          title: Text(todo.title),
          subtitle: Text("User Id: ${todo.userId}, id: ${todo.id}"),
          trailing: IconButton(
            icon: const Icon(Icons.delete), 
            onPressed: () {
              todosProvider.eliminarTodo(todo);
            },),
          textColor: Colors.white,
          tileColor: todo.completed? Colors.green : Colors.lightBlue,
          selectedColor: Colors.amberAccent.shade100,
          selectedTileColor: Colors.deepOrange.shade300,
          selected: (selectedTodo == i),
          onTap: () => albumTapped(i)));
    }
    return lista;
  }

  Future<void> nuevoTodo(BuildContext context) async {
    final Todo? todo = await Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => const TodoForm(),)
    );

    if (todo != null) {
      todosProvider.agregarTodo(todo.title);
    }
  }

  void albumTapped(int i) {
    setState(() {
      selectedTodo = i;
    });}}