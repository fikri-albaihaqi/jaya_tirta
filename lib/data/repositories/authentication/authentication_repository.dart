import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> logIn({
    String? email,
    String? password,
  }) async {
    try {
      if (email != null && password != null) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> konsumenLogIn() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }
}
