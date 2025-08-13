// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_connection/resources/auth_methods.dart';
import 'package:social_connection/resources/error_methods.dart';
import 'dart:developer' as developer;

import 'package:social_connection/resources/firestore_methods.dart';

enum AuthState { empty, loading, waitingVerify, successfull, error }

class AuthProvider extends ChangeNotifier {
  String? errorMessage;
  AuthState authState = AuthState.empty;
  final AuthMethods _auth = AuthMethods();
  final FirestoreMethods _firestore = FirestoreMethods();

  User? get currentUser => _auth.currentUser;
  Stream<User?> get stateChanges => _auth.userStateChanges;

  bool passwordVis = false;
  changePasswordVisibility() {
    passwordVis = passwordVis ? false : true;
    notifyListeners();
  }

  Future<void> signUp({
    required String password,
    required String email,
    required String username,
    required String biography,
  }) async {
    try {
      authState = AuthState.loading;
      errorMessage = null;
      notifyListeners();

      UserCredential user = await _auth.createUser(
        email: email,
        password: password,
        username: username,
        biography: AutofillHints.creditCardName,
      );
      _auth.sendEmailVerification();
      authState = AuthState.waitingVerify;
      notifyListeners();

      Timer.periodic(Duration(seconds: 1), (value) async {
        _auth.reloadUser();

        if (currentUser!.emailVerified) {
          _firestore.addCreatedUserToDB(
            email: email,
            password: password,
            username: username,
            biography: biography,
            uid: currentUser!.uid,
          );
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
      UserCredential user = await _auth.signIn(email, password);
      if (currentUser!.email == email) {
        _firestore.addResettedPasswordToDB(
          newPassword: password,
          uid: currentUser!.uid,
        );
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

  Future<void> sendPasswordResetEmail(String email) async {
    authState = AuthState.loading;
    notifyListeners();

    try {
      await _auth.sendPasswordResetEmail(email);
      authState = AuthState.successfull;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorMessage = ErrorMethods.getPasswordResetError(e.code);

      authState = AuthState.error;
      notifyListeners();
    } catch (e) {
      developer.log(e.toString());
    }
  }
}
