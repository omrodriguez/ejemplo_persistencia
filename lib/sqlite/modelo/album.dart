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

class Album {
  int? id;
  String titulo;
  String artista;
  int anio;
  Gender gender;

  Album({
    this.id, 
    required this.titulo, 
    required  this.artista,
    required  this.anio, 
    required this.gender});

  Album.vacio({
    this.id = 0,
    this.titulo = "",
    this.artista = "",
    this.anio = 0,
    this.gender = Gender.undefined,
  });

  Album.fromMap(Map<String, dynamic> json)
    : id = json['id'],
      titulo = json['titulo'],
      artista = json['artista'],
      anio = json['anio'],
      gender = Gender.values.byName(json['gender']);

  Map<String, dynamic> toMap() => {
    'id': id,
    'titulo': titulo,
    'artista': artista,
    'anio': anio,
    'gender': gender.name,
  };

  String get genero => generos[gender];

  @override
  String toString() {
    return "Album{id: $id, titulo: $titulo, artista, $artista, anio: $anio, gender:${gender.name}}";
  }
}