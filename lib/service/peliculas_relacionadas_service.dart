import 'dart:convert';
import '../models/info_peliculas_relacionadas.dart';
import 'package:http/http.dart' as http;

class PeliculasRelacionadasService{
  Future<List<Result>> obtenerInfoPeliculas(int _id) async {
    String id = _id.toString();
    String myurl = 'proyecto-labo4.onrender.com';      //servidor render
    //String myurl = 'localhost:5000';
    //String myurl = '10.0.2.1:5000'; 
    //String myurl = '192.168.0.151:5000';
    Uri url;
      url = Uri.http(myurl, '/pelicula/$id/relacionadas');
      print(url);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
      // Mapea la lista de JSON a instancias de la clase Pelicula.
      InfoPeliculasRelacionadas infoPeliculasRelacionadas = InfoPeliculasRelacionadas.fromJson(jsonDecode(response.body));
      return infoPeliculasRelacionadas.results?? [];
      } else {
        throw Exception('Error al obtener películas: ${response.statusCode}');
      }
      
    } catch (e) {
      print('Error al obtener películas: $e');

      throw Exception('Error al obtener películas: $e');
    }
  }

}