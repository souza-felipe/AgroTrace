import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/user_repository.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepository = UserRepository();

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
    required String cpf,
    required String birthDate,
    required String phone,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('Falha ao criar usuário no Firebase Auth');
      }

      final uid = userCredential.user!.uid;

      await _userRepository.saveUserData(
        uid: uid,
        name: name,
        cpf: cpf,
        birthDate: birthDate,
        phone: phone,
        email: email,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'A senha fornecida é muito fraca.';
          break;
        case 'email-already-in-use':
          errorMessage = 'Já existe uma conta com este email.';
          break;
        case 'invalid-email':
          errorMessage = 'Email inválido.';
          break;
        default:
          errorMessage = 'Erro ao criar conta: ${e.message}';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Erro inesperado: $e');
    }
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Nenhum usuário encontrado com este email.';
          break;
        case 'wrong-password':
          errorMessage = 'Senha incorreta.';
          break;
        case 'invalid-email':
          errorMessage = 'Email inválido.';
          break;
        case 'user-disabled':
          errorMessage = 'Esta conta foi desabilitada.';
          break;
        default:
          errorMessage = 'Erro ao fazer login: ${e.message}';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Erro inesperado: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Erro ao fazer logout: $e');
    }
  }

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      return await _userRepository.getUserData(uid);
    } catch (e) {
      throw Exception('Erro ao obter dados do usuário: $e');
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
      await _userRepository.updateUserData(
        uid: uid,
        name: name,
        cpf: cpf,
        birthDate: birthDate,
        phone: phone,
        email: email,
      );
    } catch (e) {
      throw Exception('Erro ao atualizar dados: $e');
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      await _userRepository.deleteUser(uid);
    } catch (e) {
      throw Exception('Erro ao deletar usuário: $e');
    }
  }
}
