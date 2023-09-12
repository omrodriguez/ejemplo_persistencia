import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'json_serializable/modelo/album_biblio.dart';
import 'json_serializable/views/album_list.dart';
import 'json_serializable/modelo/albumes.dart';

void main() {
  AlbumBiblio.leerArchivo().then((albumes) {
    runApp(ChangeNotifierProvider(create: (_) =>
      (albumes == null) ? AlbumBiblio() 
        : AlbumBiblio.fromAlbumes(Albumes.fromJson(albumes)),
      child: const MyApp()
    ),);
  });
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

