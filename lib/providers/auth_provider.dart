// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_connection/resources/auth_methods.dart';
import 'package:social_connection/resources/error_methods.dart';
import 'dart:developer' as developer;

enum AuthState { empty, loading, waitingVerify, successfull, error }

class AuthProvider extends ChangeNotifier {
  String? errorMessage;
  AuthState authState = AuthState.empty;
  final AuthMethods _authMethods = AuthMethods();

  User? get currentUser => _authMethods.currentUser;
  Stream<User?> get stateChanges => _authMethods.userStateChanges;

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

      UserCredential user = await _authMethods.createUser(email, password);
      await _authMethods.sendEmailVerification();

      authState = AuthState.waitingVerify;
      notifyListeners();

      Timer.periodic(Duration(seconds: 1), (value) async {
        await _authMethods.reloadUser();
        if (currentUser!.emailVerified) {
          authState = AuthState.successfull;
          value.cancel();
        }

        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      authState = AuthState.error;
      errorMessage = ErrorMethods.getSignUpError(e.code);
      notifyListeners();
    } catch (e) {
      developer.log(e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    authState = AuthState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      UserCredential user = await _authMethods.signIn(email, password);

      if (currentUser!.uid.isNotEmpty) {
        authState = AuthState.successfull;
        notifyListeners();
      }

      authState = AuthState.successfull;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      authState = AuthState.error;
      errorMessage = ErrorMethods.getSigInError(e.code);
      notifyListeners();
    } catch (e) {
      developer.log(e.toString());
    }
  }
}
