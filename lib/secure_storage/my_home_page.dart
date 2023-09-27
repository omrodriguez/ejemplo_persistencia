import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title ='Ejemplo Secure Storage';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storage = const FlutterSecureStorage();
  final llave = "contador";
  int _counter = 0;

  @override
  void initState() {
    leerCounter();
    super.initState();
  }

  void leerCounter() async {
    String contador = await storage.read(key: llave)?? '0';  
    setState(() {
      _counter = int.parse(contador);
    });
  }

  void borrarCounter() async {
    storage.delete(key: llave);
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });    
    await storage.write(key: llave, value: _counter.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'El botón ha sido presionado:',
            ),
            Text(
              '$_counter veces',
              style: Theme.of(context).textTheme.headlineMedium,
            ),],),),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),);}}