import 'dart:convert';
import 'package:hola_mundo/models/chucknorris.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChuckNorrisService {
  final String apiUrl = dotenv.env['CHUCK_API_URL']!;

  // Método para obtener un chiste aleatorio
  Future<ChuckNorrisJoke> getRandomJoke() async {
    final response = await http.get(Uri.parse('$apiUrl/random'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ChuckNorrisJoke.fromJson(data);
    } else {
      throw Exception('Error al obtener el chiste');
    }
  }

  // Método para obtener chistes por categoría
  Future<List<ChuckNorrisJoke>> getJokesByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$apiUrl/random?category=$category'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return [ChuckNorrisJoke.fromJson(data)];
    } else {
      throw Exception('Error al obtener chistes de la categoría $category');
    }
  }

  // Método para obtener la lista de categorías disponibles
  Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse('$apiUrl/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<String>.from(data);
    } else {
      throw Exception('Error al obtener las categorías');
    }
  }
}
