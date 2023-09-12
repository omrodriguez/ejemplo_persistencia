import 'package:flutter/material.dart';
import 'album.dart';

class AlbumBiblio extends ChangeNotifier {
  final List<Album> _listaAlbumes = [];
  
  AlbumBiblio();

  List<Album> get albumes => _listaAlbumes;

  Album getAlbumByIndex(int index) =>_listaAlbumes[index];

  void setAlbumes(List<Album> albumes) {
    _listaAlbumes.clear();
    for (Album album in albumes) {
      _listaAlbumes.add(album);
    }
    notifyListeners();
  }

  void addAlbum(Album album) {
    _listaAlbumes.add(album);
    notifyListeners();
  }

  bool updateAlbum(int index, Album album) {
    if (index >= 0 && index < _listaAlbumes.length) {
      _listaAlbumes[index] = album;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool removeAlbum(int index) {
    if (index >= 0 && index < _listaAlbumes.length) {
      _listaAlbumes.removeAt(index);
      notifyListeners();
      return true;
    }
    return false;
  }
}