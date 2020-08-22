class InputValidators{
  static String validateString(String value, {String message = "Field is required"}){
    return value == null || value.isEmpty ? message : null;
  }

  static String validatePassword(String value, {String message = "Field is required"}){
    return value == null || value.isEmpty ? message : null;
  }

  static String validateEmail(String value, {String message = "Email is required"}){
    return !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value) ? message : null;
  }

  static String validatePhone(String value, {String message = "Phone number is required"}){
    return !RegExp(r"^[0-9]{11}").hasMatch(value) ? message : null;
  }
}