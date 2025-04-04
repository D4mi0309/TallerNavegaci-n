import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hola_mundo/models/establecimiento.dart';
import 'package:http/http.dart' as http;

class EstablecimientoService {
  //! Se inicializa dotenv para cargar las variables de entorno
  final String baseUrl = dotenv.env['URL_API']!;
  final String baseUrlImg = dotenv.env['URL_API_IMG']!;

  //! getEstablecimientos
  /// Obtiene una lista de establecimientos desde la API.
  Future<List<Establecimiento>> getEstablecimientos() async {
    final response = await http.get(Uri.parse('${baseUrl}establecimientos'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return List<Establecimiento>.from(
        data.map((item) => Establecimiento.fromJson(item)),
      );
    } else {
      throw Exception('Error al cargar establecimientos');
    }
  }

  //! getEstablecimiento
  /// Obtiene un establecimiento específico por su ID desde la API.
  Future<Establecimiento> getEstablecimiento(int id) async {
    final response = await http.get(
      Uri.parse('${baseUrl}establecimientos/$id'),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Establecimiento.fromJson(json['data']);
    } else {
      throw Exception('Error al obtener el establecimiento');
    }
  }

  //! createEstablecimiento
  /// Crea un nuevo establecimiento en la API.
  Future<bool> createEstablecimiento(
    Establecimiento est, {
    File? logoFile,
  }) async {
    try {
      final uri = Uri.parse('${baseUrl}establecimientos');

      // Codificar imagen como base64 si existe
      String? base64Image;
      if (logoFile != null) {
        final imageBytes = await logoFile.readAsBytes();
        base64Image = base64Encode(imageBytes);
      }

      final body = jsonEncode(est.toJson(logoBase64: base64Image));

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      return response.statusCode ==
          201; // Código 201 indica éxito en la creación
    } catch (e) {
      throw Exception('Error al crear establecimiento: $e');
    }
  }

  //! updateEstablecimiento
  /// Actualiza un establecimiento en la API.
  Future<bool> updateEstablecimiento(
    Establecimiento est, {
    File? logoFile,
  }) async {
    try {
      final uri = Uri.parse('${baseUrl}establecimiento-update/${est.id}');

      // Codificar imagen como base64 si existe
      String? base64Image;
      if (logoFile != null) {
        final imageBytes = await logoFile.readAsBytes();
        base64Image = base64Encode(imageBytes);
      }

      final body = jsonEncode(est.toJson(logoBase64: base64Image));

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al actualizar establecimiento: $e');
    }
  }

  //! deleteEstablecimiento
  /// Elimina un establecimiento en la API.
  Future<bool> deleteEstablecimiento(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('${baseUrl}establecimientos/$id'),
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error al eliminar establecimiento: $e');
    }
  }
}
