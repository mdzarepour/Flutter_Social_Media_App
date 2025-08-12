import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addCreatedUserToDB({
    required String email,
    required String password,
    required String username,
    required String biography,
    required String uid,
  }) async {
    await _firebaseFirestore.collection('users').doc(uid).set({
      'email': email,
      'password': password,
      'username': username,
      'biography': biography,
      'followers': [],
      'followings': [],
    });
  }

  Future<void> addResettedPasswordToDB({
    required String newPassword,
    required String uid,
  }) async {
    await _firebaseFirestore.collection('users').doc(uid).update({
      'password': newPassword,
    });
  }
}
