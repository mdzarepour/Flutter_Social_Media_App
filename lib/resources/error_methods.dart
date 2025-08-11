class ErrorMethods {
  String getSignUpError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';

      case 'weak-password':
        return 'The password provided is too weak. It must be at least 6 characters long.';

      case 'invalid-email':
        return 'The email address is not valid.';

      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Please enable them in your Firebase console.';

      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';

      default:
        return 'An unexpected Firebase error occurred.';
    }
  }

  getSigInError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found for that email.';

      case 'wrong-password':
        return 'Wrong password provided for that user.';

      case 'invalid-email':
        return 'The email address is not valid.';

      case 'user-disabled':
        return 'This user has been disabled.';

      case 'too-many-requests':
        return 'Too many sign-in attempts. Try again later.';

      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';

      case 'invalid-credential':
        return 'Invalid email or password. Please try again.';

      default:
        return 'An unexpected Firebase error occurred.';
    }
  }
}
