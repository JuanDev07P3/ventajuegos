import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/videojuego.dart';

class ApiService {
  // Para emulador Android usa 10.0.2.2. Si usas dispositivo físico por Wi-Fi, pon la IP local de tu PC.
  static const String baseUrl = 'http://10.0.2.2:5285/api';

  static Future<List<Videojuego>> fetchVideojuegos() async {
    final response = await http.get(Uri.parse('$baseUrl/videojuegos'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Videojuego.fromJson(item)).toList();
    } else {
      throw Exception('Error al obtener el catálogo de videojuegos');
    }
  }

  static Future<bool> procesarVenta(int idVideojuego, int cantidad) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ventas'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'idCliente': 1,
        'idMetodoPago': 1,
        'detalles': [
          {
            'idVideojuego': idVideojuego,
            'cantidad': cantidad,
          }
        ]
      }),
    );

    return response.statusCode == 200;
  }
}