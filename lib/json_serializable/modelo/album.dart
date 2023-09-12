import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

enum Gender {
  pop, latin, rock, classic, hiphop, rap, metal, jaz, blues, reageton, undefined
}

Map generos = {
  Gender.pop: "Pop",
  Gender.blues: "Bules",
  Gender.classic: "Música clásica",
  Gender.hiphop: "Hip hop",
  Gender.jaz: "Jaz",
  Gender.latin: "Música latina",
  Gender.metal: "Rock-Metal",
  Gender.rap: "Rap",
  Gender.reageton: "Regeaton",
  Gender.rock: "Rock",
  Gender.undefined: "No definido",
};

@JsonSerializable()
class Album {
  late String titulo;
  late String artista;
  late int anio;
  late Gender gender;

  Album(this.titulo, this.artista, this.anio, this.gender);

  Album.vacio(){
    titulo = "";
    artista = "";
    anio = 0;
    gender = Gender.undefined;
  }

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  String get genero => generos[gender];
}