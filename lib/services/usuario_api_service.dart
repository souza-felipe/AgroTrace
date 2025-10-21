import 'dart:convert';
import 'package:http/http.dart' as http;

class UsuarioApiService {
  static const String baseUrl = 'http://192.168.1.9:8080/api/usuarios';
  
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  static Future<Map<String, dynamic>> criarUsuario(Map<String, dynamic> usuario) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: _headers,
        body: jsonEncode(usuario),
      );
      
      final result = jsonDecode(response.body);
      
      if (response.statusCode == 201) {
        return result;
      } else {
        throw Exception(result['message'] ?? 'Erro desconhecido');
      }
    } catch (e) {
      throw Exception('Erro ao criar usuário: $e');
    }
  }
  
  static Future<Map<String, dynamic>> buscarUsuario(String uid) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$uid'),
        headers: _headers,
      );
      
      final result = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return result;
      } else if (response.statusCode == 404) {
        return result;
      } else {
        throw Exception(result['message'] ?? 'Erro desconhecido');
      }
    } catch (e) {
      throw Exception('Erro ao buscar usuário: $e');
    }
  }
  
  static Future<Map<String, dynamic>> atualizarUsuario(String uid, Map<String, dynamic> usuario) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$uid'),
        headers: _headers,
        body: jsonEncode(usuario),
      );
      
      final result = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return result;
      } else {
        throw Exception(result['message'] ?? 'Erro desconhecido');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar usuário: $e');
    }
  }
  
  static Future<Map<String, dynamic>> listarUsuarios() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: _headers,
      );
      
      final result = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return result;
      } else {
        throw Exception(result['message'] ?? 'Erro desconhecido');
      }
    } catch (e) {
      throw Exception('Erro ao listar usuários: $e');
    }
  }
  
  static Future<Map<String, dynamic>> deletarUsuario(String uid) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$uid'),
        headers: _headers,
      );
      
      final result = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return result;
      } else {
        throw Exception(result['message'] ?? 'Erro desconhecido');
      }
    } catch (e) {
      throw Exception('Erro ao deletar usuário: $e');
    }
  }
}
