class Validator {

  static String? validateNonNull(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static bool isValidEmail(String value) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );
    return emailRegex.hasMatch(value.trim());
  }

  static String? validateEmail(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName??'Email'} is required';
    }
    if (!isValidEmail(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName??'Password'} is required';
    }
    return checkPasswordPolicy(value);
  }

  static String? checkPasswordPolicy(String p) {
    if (p.length < 8 ||
        p.length > 99 ||
        !p.contains(RegExp(r"[a-z]")) ||
        !p.contains(RegExp(r"[A-Z]")) ||
        !p.contains(RegExp(r"[0-9]")) ||
        !p.contains(RegExp(r'[^\w\d\s]'))) {
      return "Password must be at least 8 characters, contain at least one lowercase, uppercase, number and special character";
    }
    return null;
  }



}