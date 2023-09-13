import 'package:ejemplo_persistencia/sqlite/modelo/manejador_database.dart';
import 'album_form.dart';
import 'album_vista.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modelo/album.dart';
import '../modelo/album_biblio.dart';

class AlbumLista extends StatefulWidget {

  const AlbumLista({super.key});

  @override
  State<AlbumLista> createState() => _AlbumListaState();
}

class _AlbumListaState extends State<AlbumLista> {
  bool dbReaded = false;
  int selectedAlbum = 0;
  AlbumBiblio? albumes;
  ManejadorDatabase? manejadorDB = ManejadorDatabase.getInstance();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      albumes = context.read<AlbumBiblio>();
      manejadorDB!.albumes().then((value) { 
        albumes!.setAlbumes(value);
        setState(() {
          dbReaded = true;
        });
      });
    });
  }

  @override
  void dispose() {
    manejadorDB!.cerrarDB();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    albumes = Provider.of<AlbumBiblio>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Biblioteca de Albumes"),
      ),
      body: !dbReaded? const Center(child: CircularProgressIndicator()) 
        : (albumes!.albumes.isNotEmpty)? ListView(
          padding: const EdgeInsets.all(10),
          children: ListTile.divideTiles(context: context, 
            tiles: crearLista(), color:Colors.amber).toList(),
          )
        : Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                capturarAlbum(context);
              },
              child: const Text("Agregar Album"),
            )
          ),
        ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          capturarAlbum(context);
        },
        tooltip: 'Nuevo album',
        child: const Icon(Icons.add),
      ),);}

  List<Widget> crearLista() {
    final List<Widget> lista = <Widget>[];
    for(int i = 0; i < albumes!.albumes.length; i++ ){
      Album album = albumes!.getAlbumByIndex(i);
      lista.add(
        ListTile(
          leading: const Icon(Icons.album),
          title: Text(album.titulo),
          subtitle: Text("${album.artista}, Año: ${album.anio}, Género: ${album.genero}"),
          trailing: SizedBox(height: 30, width: 145,
            child: crearButtonsBar(i)),
          textColor: Colors.white,
          tileColor: Colors.lightBlue,
          selectedColor: Colors.blue,
          selectedTileColor: Colors.deepOrange.shade100,
          selected: (selectedAlbum == i),
          onTap: () => albumTapped(i)));
    }
    return lista;
  }

  Widget crearButtonsBar(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
    children: [
      IconButton(
        tooltip: "Ver",
        onPressed: () { mostrarAlbum(context, index);}, 
        icon: const Icon(Icons.search)),
      IconButton(
        tooltip: "Editar",
        onPressed: () {
          actualizarAlbum(context, index);
        }, 
        icon: const Icon(Icons.edit)),
      IconButton(
        tooltip: "Eliminar",
        onPressed: () { removerAlbum(index);}, 
        icon: const Icon(Icons.delete)),
    ],);
  }

  void albumTapped(int i) {
    setState(() {
      selectedAlbum = i;
    });
  }

  Future<void> capturarAlbum(BuildContext context) async {
    final Album? album = await Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => const AlbumForm(),)
    );

    if (album != null) {
      int id = await manejadorDB!.insertarAlbum(album);
      album.id = id;
      albumes!.addAlbum(album);
    }
  }

  void mostrarAlbum(BuildContext context, int index) {
    Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AlbumVista(album: albumes!.getAlbumByIndex(index),),));
  }

  Future<void> actualizarAlbum(BuildContext context, int index,) async {
    Album? album = await Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => AlbumForm(album: albumes!.getAlbumByIndex(index)),)
    );

    if(album != null){
      albumes!.updateAlbum(index, album);
      manejadorDB!.actualizarAlbum(album);
    }
  }

  bool removerAlbum(int index) {
    Album album = albumes!.getAlbumByIndex(index);
    var eliminado = albumes!.removeAlbum(index);
    manejadorDB!.removerAlbum(album.id!);
    return eliminado;
  }
}