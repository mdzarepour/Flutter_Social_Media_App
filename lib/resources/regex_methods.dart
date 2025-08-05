class RegexMethods {
  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username.';
    }
    final RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9_]{3,}$');
    if (!usernameRegExp.hasMatch(value)) {
      return 'Username must be at least 3 characters long and contain only letters, numbers, or underscores.';
    }
    return null;
  }

  String? biographyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a biography.';
    }
    if (value.length < 5 || value.length > 50) {
      return 'Biography must be between 5 and 50 characters long.';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address.';
    }
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    if (!passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character.';
    }
    return null;
  }
}
