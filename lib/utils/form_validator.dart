class FormValidator {
  static String? requiredField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This value is required';
    }
    return null;
  }
}
