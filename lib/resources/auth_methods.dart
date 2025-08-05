// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> signUp({
    required String username,
    required String email,
    required String biography,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.uid.isNotEmpty) {
        try {
          await _firebaseFirestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
                'username': username,
                'email': email,
                'password': password,
                'biography': biography,
                'followers': [],
                'following': [],
              });
        } on FirebaseException catch (e) {
          print(e.message);
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
