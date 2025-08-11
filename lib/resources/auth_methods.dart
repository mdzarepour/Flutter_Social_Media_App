// ignore_for_file: avoid_print, unused_local_variable
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_connection/resources/error_methods.dart';

enum AuthState { empty, loading, waitingVerify, successfull, error }

class AuthMethods extends ChangeNotifier {
  String? errorMessage;
  final ErrorMethods _errorMethods = ErrorMethods();
  AuthState authState = AuthState.empty;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get stateChanges => _firebaseAuth.authStateChanges();

  Future<void> signUp({
    required String username,
    required String biography,
    required String email,
    required String password,
  }) async {
    try {
      authState = AuthState.loading;
      errorMessage = null;
      notifyListeners();

      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await currentUser!.sendEmailVerification();
      authState = AuthState.waitingVerify;
      notifyListeners();

      final Timer timer = Timer.periodic(Duration(seconds: 1), (value) async {
        currentUser!.reload();
        print(value.tick);
        if (currentUser!.emailVerified) {
          authState = AuthState.successfull;
          value.cancel();
        }

        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      authState = AuthState.error;
      errorMessage = _errorMethods.getSignUpError(e.code);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    authState = AuthState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (currentUser!.uid.isNotEmpty) {
        authState = AuthState.successfull;
        notifyListeners();
      }

      authState = AuthState.successfull;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      authState = AuthState.error;
      errorMessage = _errorMethods.getSigInError(e.code);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    errorMessage = null;
  }
}
