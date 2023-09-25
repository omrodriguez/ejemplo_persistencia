import 'package:flutter/material.dart';
import '../modelo/todo.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({super.key});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController ctrTitle = TextEditingController();
  
  @override
  void dispose() {
    ctrTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Nuevo todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Título del album',
                  ),
                  controller: ctrTitle,
                  validator: (String? valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Proporcione la tarea por hacer';
                    } return null;
                  },),
                const SizedBox(height: 10.0,),                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  ElevatedButton(
                    onPressed: _validar, 
                    child: const Text("Aceptar")),
                  const SizedBox(width: 20.0,),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(), 
                    child: const Text("Cancelar")),
                ],)]),)),));}

  void _validar() {
    final form = _formkey.currentState;
    if (form?.validate() == false) {
      return;
    }
    final Todo todo = Todo(
        10,
        1,
        ctrTitle.text,
        false,
    );
    Navigator.pop(context, todo);
  }}