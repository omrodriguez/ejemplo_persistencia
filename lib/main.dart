import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sqlite/modelo/album_biblio.dart';
import 'sqlite/views/album_list.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) =>
    AlbumBiblio(),
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
      home: const AlbumLista(),
    );
  }
}

