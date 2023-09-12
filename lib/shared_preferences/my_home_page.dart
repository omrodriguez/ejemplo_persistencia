import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title ='Ejemplo SharedPreferences';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    leerCounter();
    super.initState();
  }

  void leerCounter() async {
    SharedPreferences.getInstance().then((prefs) {
      final int? counter = prefs.getInt("counter");
      if (counter != null) {
        //borrarCounter();
        setState(() {
          _counter = counter;
        });}});}

  void borrarCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("counter");
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("counter", _counter);
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