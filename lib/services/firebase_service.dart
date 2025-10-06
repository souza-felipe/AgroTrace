import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirebaseService {
  static FirebaseAuth get auth => FirebaseAuth.instance;

  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  static User? get currentUser => auth.currentUser;

  static bool get isUserLoggedIn => currentUser != null;

  static Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } catch (e) {
      return null;
    }
  }

  static Future<UserCredential?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return null;
    }
  }

  static Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      // Erro no logout
    }
  }
}
