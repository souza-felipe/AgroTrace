import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Salvar dados do usuário
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
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection('users')
          .doc(uid)
          .set(userData);
    } catch (e) {
      throw Exception('Erro ao salvar dados no Firestore: $e');
    }
  }

  // Obter dados do usuário
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Erro ao buscar dados do usuário: $e');
    }
  }

  // Atualizar dados do usuário
  Future<void> updateUserData({
    required String uid,
    String? name,
    String? cpf,
    String? birthDate,
    String? phone,
    String? email,
  }) async {
    try {
      final updateData = <String, dynamic>{
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (name != null) updateData['name'] = name.trim();
      if (cpf != null) updateData['cpf'] = _formatCpf(cpf);
      if (birthDate != null) updateData['birthDate'] = _formatBirthDate(birthDate);
      if (phone != null) updateData['phone'] = _formatPhone(phone);
      if (email != null) updateData['email'] = email.trim().toLowerCase();

      await _firestore
          .collection('users')
          .doc(uid)
          .update(updateData);
    } catch (e) {
      throw Exception('Erro ao atualizar dados: $e');
    }
  }

  // Deletar usuário
  Future<void> deleteUser(String uid) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .delete();
    } catch (e) {
      throw Exception('Erro ao deletar usuário: $e');
    }
  }

  // Verificar se usuário existe
  Future<bool> userExists(String uid) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(uid)
          .get();
      
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  // Métodos de formatação privados
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
