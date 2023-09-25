import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({super.key});

  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  final _controladorNombre = TextEditingController();
  final _controladorEmail = TextEditingController();
  final _controladorPass = TextEditingController();
  final _llaveForm = GlobalKey<FormState>();
  final _channel = WebSocketChannel.connect(
    Uri.parse("wss://echo.websocket.events"));

  @override
  void dispose() {
    _controladorEmail.dispose();
    _controladorNombre.dispose();
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Ejemplo de WebSockets"),
      ),
      body: Column(
        children: [
          _formaDeAutenticacion(),
          const Divider(height: 5,),
          StreamBuilder(
            stream: _channel.stream, 
            builder: ((context, snapshot) => 
            Text(snapshot.hasData ? '${snapshot.data}' : 'No hay datos'))
          ),
        ],
      ),);
  }

  Widget _formaDeAutenticacion() {
    return Form(
      key: _llaveForm,
      child: SizedBox(width: 300,
        child: Padding(
          padding: const EdgeInsets.all(20.0,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _controladorNombre,
                decoration: const InputDecoration(labelText: "Nombre de suario"),
                validator: (text) =>
                  text!.isEmpty ? 'Introducir el nombre de usuario' : null,
              ),
              TextFormField(
                controller: _controladorEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: "Correo electrónico"),
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'Introducir el correo electrónico';
                  }
                  final regex = RegExp('[^@]+@[^.]+..+');
                  if (!regex.hasMatch(text)) {
                    return 'Introducir un correo electrónico válido';
                  }
                  return null;
                }
              ),
              TextFormField(
                controller: _controladorPass,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Contraseña"),
                validator: (text) =>
                  text!.isEmpty ? 'Introducir una contraseña' : null,
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: _validar, 
                child: const Text('Continuar'),),
            ],)),),);}

  void _validar() {
    final forma = _llaveForm.currentState;
    if (forma?.validate() == false) {
      return;
    }

    final nombre = _controladorNombre.text;
    final email = _controladorEmail.text;
    final pass = _controladorPass.text;
    String mensaje = '{nombre: $nombre, email: $email, pass: $pass}';

    _channel.sink.add(mensaje);
  }
}
