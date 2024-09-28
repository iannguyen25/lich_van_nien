import 'package:firebase_auth/firebase_auth.dart';

enum AuthError {
  userNotFound,
  wrongPassword,
  weakPassword,
  emailAlreadyInUse,
  unknown,
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthError.userNotFound;
      } else if (e.code == 'wrong-password') {
        throw AuthError.wrongPassword;
      }
      throw AuthError.unknown;
    }
  }

  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthError.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        throw AuthError.emailAlreadyInUse;
      }
      throw AuthError.unknown;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
