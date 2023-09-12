// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      json['titulo'] as String,
      json['artista'] as String,
      json['anio'] as int,
      $enumDecode(_$GenderEnumMap, json['gender']),
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'titulo': instance.titulo,
      'artista': instance.artista,
      'anio': instance.anio,
      'gender': _$GenderEnumMap[instance.gender]!,
    };

const _$GenderEnumMap = {
  Gender.pop: 'pop',
  Gender.latin: 'latin',
  Gender.rock: 'rock',
  Gender.classic: 'classic',
  Gender.hiphop: 'hiphop',
  Gender.rap: 'rap',
  Gender.metal: 'metal',
  Gender.jaz: 'jaz',
  Gender.blues: 'blues',
  Gender.reageton: 'reageton',
  Gender.undefined: 'undefined',
};
