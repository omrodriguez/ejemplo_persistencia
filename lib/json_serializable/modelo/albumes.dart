import 'package:json_annotation/json_annotation.dart';

import 'album.dart';

part 'albumes.g.dart';

@JsonSerializable(explicitToJson: true)
class Albumes {
  @JsonKey(name: 'lista_albumes')
  List<Album> listaAlbumes = [];

  Albumes();

  factory Albumes.fromJson(Map<String, dynamic> json) => _$AlbumesFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumesToJson(this);

  List<Album> get albumes => listaAlbumes;
}