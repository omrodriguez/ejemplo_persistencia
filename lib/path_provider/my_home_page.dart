import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title ='Ejemplo SharedPreferences';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String nombreArchivo = "contador.txt";

  @override
  void initState() {
    leerCounter();
    super.initState();
  }

  Future<String> get _pathLocal async {
    final directorio = await getApplicationDocumentsDirectory();
    return directorio.path;
  }

  Future<File> get _archivoLocal async {
    final path = await _pathLocal;
    return File('$path${Platform.pathSeparator}$nombreArchivo');
  }

  void leerCounter() async {
    try {
      final archivo = await _archivoLocal;
      if (archivo.existsSync()) {
        final contenido = await archivo.readAsString();
        int counter = int.parse(contenido);
        //borrarCounter();
        setState(() {
          _counter = counter;
        });} else {
        print("El archivo ${archivo.absolute} no existe");
      }} catch (e) {
      print("Ocurrió un error de lectura");
    }}

  void borrarCounter() async {
    final archivo = await _archivoLocal;
    if (archivo.existsSync()) {
      archivo.delete();
    }}

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    final archivo = await _archivoLocal;
    archivo.writeAsString('$_counter');
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