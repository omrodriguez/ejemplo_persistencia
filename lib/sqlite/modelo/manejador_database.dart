import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'album.dart';


class ManejadorDatabase {
  static const String nombreDb = 'albumes_database.db';
  static const String nombreTabla = 'albumes';
  static Database? db;
  static ManejadorDatabase? _instance;

  ManejadorDatabase._();

  static ManejadorDatabase getInstance() {
    _instance??=ManejadorDatabase._();
    return _instance!;
  }

  Future<Database> getDB() async {
    db??= await _inicializarDB();
    return db!;
  }

  Future<Database> _inicializarDB() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      join(path, nombreDb),
      onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE $nombreTabla(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT NOT NULL, artista TEXT NOT NULL, anio, INTEGER, gender TEXT NOT NULL)"
      );},
      version: 1,
    );
  }

  Future<int> insertarAlbum(Album album) async {
    int result = 0;
    db??= await getDB();
    result = await db!.insert(nombreTabla, 
                    album.toMap(), 
                    conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<List<Album>> albumes() async {
    db??= await getDB();
    final List<Map<String, Object?>> mapa = await db!.query(nombreTabla);
    return mapa.map((e) => Album.fromMap(e)).toList();
  }

  Future<int> actualizarAlbum(Album album) async {
    int result = 0;
    db??= await getDB();
    result = await db!.update(nombreTabla, 
                    album.toMap(), 
                    where: 'id = ?',
                    whereArgs: [album.id]);
    return result;
  }

  Future<int> removerAlbum(int id) async {
    db??= await getDB();
    return await db!.delete(nombreTabla, 
                    where: 'id = ?',
                    whereArgs: [id]);
  }

  Future<void> cerrarDB() async {
    db??= await getDB();
    db!.close();
  }
}