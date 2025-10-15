import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static const String _userKey = 'user_data';

  Future<void> saveUserData({
    required String uid,
    required String name,
    required String cpf,
    required String birthDate,
    required String phone,
    required String email,
  }) async {
    try {
      final userData = {
        'uid': uid,
        'name': name.trim(),
        'cpf': _formatCpf(cpf),
        'birthDate': _formatBirthDate(birthDate),
        'phone': _formatPhone(phone),
        'email': email.trim().toLowerCase(),
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(userData);
      await prefs.setString(_userKey, jsonString);
    } catch (e) {
      throw Exception('Erro ao salvar dados localmente: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_userKey);

      if (jsonString != null) {
        final data = jsonDecode(jsonString) as Map<String, dynamic>;
        return data;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Erro ao buscar dados do usuário: $e');
    }
  }

  Future<void> updateUserData({
    required String uid,
    String? name,
    String? cpf,
    String? birthDate,
    String? phone,
    String? email,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_userKey);

      if (jsonString != null) {
        final data = jsonDecode(jsonString) as Map<String, dynamic>;

        if (name != null) data['name'] = name.trim();
        if (cpf != null) data['cpf'] = _formatCpf(cpf);
        if (birthDate != null) data['birthDate'] = _formatBirthDate(birthDate);
        if (phone != null) data['phone'] = _formatPhone(phone);
        if (email != null) data['email'] = email.trim().toLowerCase();

        data['updatedAt'] = DateTime.now().toIso8601String();

        final updatedJsonString = jsonEncode(data);
        await prefs.setString(_userKey, updatedJsonString);
      }
    } catch (e) {
      throw Exception('Erro ao atualizar dados: $e');
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    } catch (e) {
      throw Exception('Erro ao deletar usuário: $e');
    }
  }

  Future<bool> userExists(String uid) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_userKey);
      return jsonString != null;
    } catch (e) {
      return false;
    }
  }

  String _formatCpf(String cpf) {
    final cleanCpf = cpf.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanCpf.length == 11) {
      return '${cleanCpf.substring(0, 3)}.${cleanCpf.substring(3, 6)}.${cleanCpf.substring(6, 9)}-${cleanCpf.substring(9)}';
    }
    return cpf;
  }

  String _formatPhone(String phone) {
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanPhone.length == 11) {
      return '(${cleanPhone.substring(0, 2)}) ${cleanPhone.substring(2, 7)}-${cleanPhone.substring(7)}';
    } else if (cleanPhone.length == 10) {
      return '(${cleanPhone.substring(0, 2)}) ${cleanPhone.substring(2, 6)}-${cleanPhone.substring(6)}';
    }
    return phone;
  }

  String _formatBirthDate(String birthDate) {
    final cleanBirthDate = birthDate.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanBirthDate.length == 8) {
      return '${cleanBirthDate.substring(0, 2)}/${cleanBirthDate.substring(2, 4)}/${cleanBirthDate.substring(4)}';
    }
    return birthDate;
  }
}
