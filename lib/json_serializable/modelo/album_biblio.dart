import 'dart:convert';
import 'package:flutter/material.dart';
import 'album.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'albumes.dart';

class AlbumBiblio extends ChangeNotifier {
  late final Albumes albumes;
  static String nombreArchivo = "albumes.json";

  AlbumBiblio() { albumes = Albumes();}

  AlbumBiblio.fromAlbumes(this.albumes);

  Album getAlbumByIndex(int index) =>albumes.listaAlbumes[index];

  void addAlbum(Album album) {
    albumes.listaAlbumes.add(album);
    notifyListeners();
  }

  bool updateAlbum(int index, Album album) {
    if (index >= 0 && index < albumes.listaAlbumes.length) {
      albumes.listaAlbumes[index] = album;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool removeAlbum(int index) {
    if (index >= 0 && index < albumes.listaAlbumes.length) {
      albumes.listaAlbumes.removeAt(index);
      notifyListeners();
      return true;
    }
    return false;
  }

  static Future<String> get _pathLocal async {
    final directorio = await getApplicationDocumentsDirectory();
    return directorio.path;
  }

  static Future<File> get _archivoLocal async {
    final path = await _pathLocal;
    return File('$path${Platform.pathSeparator}$nombreArchivo');
  }

  Future<File> guardarAlbumes() async{
    final archivo = await _archivoLocal;
    return archivo.writeAsString(jsonEncode(albumes.toJson()));
  }

  static Future<Map<String, dynamic>?> leerArchivo() async {
    final archivo = await _archivoLocal;
    if (archivo.existsSync()) {
      String contenido = await archivo.readAsString();
      return jsonDecode(contenido);
    }
    return null;
  }
}