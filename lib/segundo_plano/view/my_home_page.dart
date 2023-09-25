import 'package:flutter/material.dart';
import '../model/photo.dart';
import '../model/http_controller.dart' as http_controller;
import 'package:http/http.dart' as http;

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Ejemplo parsear en segundo plano"),
      ),
      body: FutureBuilder<List<Photo>>(
        future: http_controller.descargarPhotos(http.Client()),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return const Center(child: Text("Ocurrió un error en la descarga"),);
          } else if (snapshot.hasData) {
            return ListaPhotos(photos: snapshot.data!);
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }}),);}}

class ListaPhotos extends StatelessWidget {
  const ListaPhotos({super.key, required this.photos});

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double factor = width/150;
    int cols = (factor < 2)? 2 : (factor > 5)? 5 : factor.toInt();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,),
      itemCount: photos.length, 
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      });}}