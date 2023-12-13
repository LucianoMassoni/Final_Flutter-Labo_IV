import 'package:flutter/material.dart';
import 'package:flutter_final/widgets/portadaPeliculaWidget.dart';
import '../widgets/GenerosDropdownButton.dart';
import '../models/info_peliculas.dart';
import '../service/peliculas_service.dart';


class PantallaPeliculas extends StatefulWidget{
  const PantallaPeliculas ({super.key});

  @override
  State<PantallaPeliculas> createState() => _PantallaPeliculasState();
}

class _PantallaPeliculasState extends State<PantallaPeliculas> {
  final PeliculasService _peliculasService = PeliculasService();
  
  List<Result> peliculas = []; // Asume que tienes una lista de películas

  void _actualizarPeliculas(String genero) async {
    try {
      InfoPeliculas nuevasPeliculas = await _peliculasService.obtenerPeliculasPorGenero(genero, 1);
      setState(() {
        peliculas = nuevasPeliculas.results ?? [];

      });
    } catch (error) {
      // Manejar errores, por ejemplo, mostrar un mensaje al usuario.
      print('Error al obtener películas: $error');

    }
  }
  
  @override
  Widget build(BuildContext context){
    int? idPelicula;
    return Scaffold(
      
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(228, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: const Text("tasdfasdfasdf"),
        // backgroundColor: Color.fromARGB(228, 255, 255, 255),
        // elevation: 0,
        // centerTitle: true,
        actions: <Widget> [
          const Spacer(),
          // TODO - en vez de un incon button mejor solo un logo.
          IconButton(
            padding: const EdgeInsets.all(10),
            icon: const Icon(Icons.home),       // TODO - Este cambiarlo por un logo
            onPressed: (){
              _actualizarPeliculas("-");        //TODO - resetear el genero y mostrar todas las peliculas.
            }
          ),
          const Spacer(),
          const Text("Genero:"),
          GenerosDropdownButton(onGeneroChanged: _actualizarPeliculas),
          const Spacer(),
          IconButton(
            padding: const EdgeInsets.all(10),
            icon: const Icon(Icons.account_circle),
            onPressed: (){
              Navigator.pushNamed(
                context,
                "perfil"
              );
            }
          ),
          const Spacer(),
        ],
      ),
      body: GestureDetector(
        child:SafeArea(
          child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(10),
          itemCount: peliculas.length,
          itemBuilder: (context, index) {
            idPelicula = peliculas[index].id?? null;
            return PortadaPeliculaWidget(
              id: peliculas[index].id?? -0, 
              imageUrl: peliculas[index].posterPath != null
                ? 'https://image.tmdb.org/t/p/w500${peliculas[index].posterPath}'
                : 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', 
                
            );
          },
          ),
      ),
        onTap: () async {
          Navigator.pushNamed(
            context,
            'pelicula',
            arguments: idPelicula,
          );
        },  
      )
    );
  }
}

 

/*
class _PantallaPeliculasState extends State<PantallaPeliculas> {
  final PeliculasService _peliculasService = PeliculasService();
  List<Result> peliculas = [];
  int _paginaActual = 1;
  bool _cargando = false;

  void _actualizarPeliculas(String genero) async {
    if (_cargando) {
      return;
    }
    setState(() {
      _cargando = true;
    });

    try {
      InfoPeliculas nuevasPeliculas =
          await _peliculasService.obtenerPeliculasPorGenero(genero, _paginaActual);
      setState(() {
        peliculas.addAll(nuevasPeliculas.results ?? []);
        _paginaActual++;
      });
    } catch (error) {
       print('Error al obtener películas en pantallaPeliculas: $error');
    } finally {
      setState(() {
        _cargando = false;
      });
    }
  }
  
  int? idPelicula;
 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(228, 255, 255, 255),
      appBar: AppBar(
        
        // title: const Text("tasdfasdfasdf"),
        // backgroundColor: Color.fromARGB(228, 255, 255, 255),
        // elevation: 0,
        // centerTitle: true,
        actions: <Widget> [
          const Spacer(),
          IconButton(
            padding: const EdgeInsets.all(10),
            icon: const Icon(Icons.home),       // TODO - Este cambiarlo por un logo
            onPressed: (){
              print("home");          //TODO - resetear el genero y mostrar todas las peliculas.
            }
          ),
          const Spacer(),
          const Text("Genero:"),
          GenerosDropdownButton(onGeneroChanged: _actualizarPeliculas),
          const Spacer(),
          IconButton(
            padding: const EdgeInsets.all(10),
            icon: const Icon(Icons.account_circle),
            onPressed: (){
              Navigator.pushNamed(
                context,
                "perfil"
              );
            }
          ),
          const Spacer(),
        ],
      ),
      body: GestureDetector(
          child:SafeArea(
          child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(10),
          itemCount: peliculas.length,
          itemBuilder: (context, index) {
            idPelicula = peliculas[index].id?? null;
            return PortadaPeliculaWidget(
              id: peliculas[index].id?.toString() ?? '', 
              imageUrl: peliculas[index].posterPath != null
                ? 'https://image.tmdb.org/t/p/w500${peliculas[index].posterPath}'
                : 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', 
                
            );
          },
          ),
      ),
        onVerticalDragEnd: (details) {
          // Implementa tu lógica de infinito scroll aquí
          if (details.primaryVelocity! > 0) {
            _actualizarPeliculas("generoActual"); // Actualiza el género actual o como lo manejes
          }
        },
      ),
    );
  }
}

*/