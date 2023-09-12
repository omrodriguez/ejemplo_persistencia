// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albumes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Albumes _$AlbumesFromJson(Map<String, dynamic> json) => Albumes()
  ..listaAlbumes = (json['lista_albumes'] as List<dynamic>)
      .map((e) => Album.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$AlbumesToJson(Albumes instance) => <String, dynamic>{
      'lista_albumes': instance.listaAlbumes.map((e) => e.toJson()).toList(),
    };
