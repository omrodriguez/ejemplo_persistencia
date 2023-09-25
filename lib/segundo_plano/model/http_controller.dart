import 'package:ejemplo_persistencia/segundo_plano/model/photo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

Future<List<Photo>> descargarPhotos(http.Client client) async {
  const String urlPhotos = 'https://jsonplaceholder.typicode.com/photos';
  final res = await client.get(Uri.parse(urlPhotos));
  return compute(paresarPhotos, res.body);
}

List<Photo> paresarPhotos(String respuesta) {
  final parseado = jsonDecode(respuesta).cast<Map<String, dynamic>>();

  return parseado.map<Photo>((json) => Photo.fromJson(json)).toList();
}