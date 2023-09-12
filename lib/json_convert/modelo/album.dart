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
  late String _titulo;
  late String _artista;
  late int _anio;
  late Gender _gender;

  Album(this._titulo, this._artista, this._anio, this._gender);

  Album.vacio(){
    _titulo = "";
    _artista = "";
    _anio = 0;
    _gender = Gender.undefined;
  }

  Album.fromJson(Map<String, dynamic> json)
    : _titulo = json['titulo'],
      _artista = json['artista'],
      _anio = json['anio'],
      _gender = Gender.values.byName(json['gender']);

  Map<String, dynamic> toJson() => {
    'titulo': _titulo,
    'artista': _artista,
    'anio': _anio,
    'gender': _gender.name,
  };

  String get titulo => _titulo;
  String get artista => _artista;
  int get anio => _anio;
  String get genero => generos[_gender];
  Gender get gender => _gender; 

  set titulo(String titulo) => _titulo;
  set artista(String artista) => _artista;
  set anio(int anio) => _anio;
  set gender(Gender genero) => _gender;

}