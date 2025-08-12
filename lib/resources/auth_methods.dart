import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get userStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> createUser(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    return userCredential;
  }

  Future<void> sendEmailVerification() async {
    await currentUser!.sendEmailVerification();
  }

  Future<UserCredential> signIn(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    return userCredential;
  }

  Future<void> reloadUser() async {
    await currentUser!.reload();
  }
}
