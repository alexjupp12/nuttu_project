import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';

class AuthService {
  // URL base del servidor muy importante para realizar la conexión
  final String _baseUrl =
      'http://10.0.2.2:3000'; // Cambia esto por la URL de tu servidor
  //--------------------------------------------------

  // Función para registrar un nuevo usuario
  Future<bool> register(String email, String password) async {
    final url = Uri.parse('$_baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      // 201 es "ok creado"
      return response.statusCode == 201;
    } catch (e) {
      log('Error en el servicio de autenticación: $e'); // Para depuración
      return false;
    }
  }

  //Método para uniciar sesión
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      // 200 es "ok"
      return response.statusCode == 200;
    } catch (e) {
      log('Error en el servicio de autenticación: $e'); // Para depuración
      return false;
    }
  }
}
