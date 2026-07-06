class AppInputValidators {
  const AppInputValidators._();

  static String? email(String? value) {
    final String email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Please enter your email address';
    }

    final bool isValidEmail = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email);

    if (!isValidEmail) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? password(String? value) {
    final String password = value ?? '';

    if (password.trim().isEmpty) {
      return 'Please enter your password';
    }

    return null;
  }

  static String? requiredField(
      String? value, {
        required String fieldName,
      }) {
    final String input = value?.trim() ?? '';

    if (input.isEmpty) {
      return 'Please enter $fieldName';
    }

    return null;
  }

  static String? fullName(String? value) {
    final String name = value?.trim() ?? '';

    if (name.isEmpty) {
      return 'Please enter your full name';
    }

    if (name.length < 2) {
      return 'Please enter a valid name';
    }

    return null;
  }

  static String? age(String? value) {
    final int? age = int.tryParse(value?.trim() ?? '');

    if (age == null) {
      return 'Please enter your age';
    }

    if (age < 13 || age > 120) {
      return 'Please enter a valid age';
    }

    return null;
  }

  static String? confirmPassword(
      String? value,
      String password,
      ) {
    final String confirmPassword = value ?? '';

    if (confirmPassword.trim().isEmpty) {
      return 'Please confirm your password';
    }

    if (confirmPassword != password) {
      return 'Password does not match';
    }

    return null;
  }

  static String? strongPassword(String? value) {
    final String password = value ?? '';

    if (password.trim().isEmpty) {
      return 'Please enter your password';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }

    final bool hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final bool hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final bool hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final bool hasSpecialChar = RegExp(
      r'[!@#$%^&*(),.?":{}|<>]',
    ).hasMatch(password);

    if (!hasUppercase ||
        !hasLowercase ||
        !hasNumber ||
        !hasSpecialChar) {
      return 'Password must include uppercase, lowercase, number and special character';
    }

    return null;
  }
}