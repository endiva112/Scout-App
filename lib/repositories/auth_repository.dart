import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Stream del estado de autenticación
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Usuario actual
  User? get currentUser => _auth.currentUser;

  // Crear usuario anónimo
  Future<User?> signInAnonymously() async {
    final result = await _auth.signInAnonymously();
    return result.user;
  }

  // Login con Google vinculando la cuenta anónima existente
  Future<User?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    if (_auth.currentUser?.isAnonymous ?? false) {
      try {
        final result = await _auth.currentUser!.linkWithCredential(credential);
        return result.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'credential-already-in-use') {
          final result = await _auth.signInWithCredential(credential);
          return result.user;
        }
        rethrow;
      }
    }

    final result = await _auth.signInWithCredential(credential);
    return result.user;
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Eliminar cuenta
  Future<void> deleteAccount() async {
    await _auth.currentUser?.delete();
    await _googleSignIn.signOut();
  }
}