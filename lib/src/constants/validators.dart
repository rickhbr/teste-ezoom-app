class FieldValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um e-mail.';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, insira um e-mail válido.';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma senha.';
    }
    if (value.length < 8) {
      return 'A senha deve ter pelo menos 8 caracteres.';
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, insira um nome.';
    }
    if (value.trim().length < 2) {
      return 'O nome deve ter pelo menos 2 caracteres.';
    }
    return null;
  }
}
