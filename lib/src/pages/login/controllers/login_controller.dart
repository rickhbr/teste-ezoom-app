import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:teste_app/src/constants/animations.dart';
import 'package:teste_app/src/routes/app_routes.dart';
import 'package:teste_app/src/services/apis/auth/auth_service.dart';
import 'package:teste_app/src/services/navigation_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();
  // Login
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  // Registro
  Rx<TextEditingController> createNameController = TextEditingController().obs;
  Rx<TextEditingController> createEmailController = TextEditingController().obs;
  Rx<TextEditingController> createPasswordController =
      TextEditingController().obs;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  RxBool isLogin = true.obs;
  RxBool isLoading = false.obs;

  void handleLogin() {
    isLogin.value = !isLogin.value;
    clear();
  }

  bool validateLoginForm() {
    return loginFormKey.currentState?.validate() ?? false;
  }

  bool validateRegisterForm() {
    return registerFormKey.currentState?.validate() ?? false;
  }

  void clear() {
    emailController.value.text = '';
    passwordController.value.text = '';
    createNameController.value.text = '';
    createEmailController.value.text = '';
    createPasswordController.value.text = '';
  }

// Método de Login
  Future<void> attemptLogin() async {
    if (validateLoginForm()) {
      isLoading(true);
      bool result = await _authService.login(
          emailController.value.text, passwordController.value.text);
      if (result) {
        isLoading(false);
        NavigationService.push(PagesRoutes.home);
      } else {
        isLoading(false);
        _showLoginFailedDialog();
      }
    }
  }

  // Método de Registro
  Future<void> attemptRegister() async {
    if (validateRegisterForm()) {
      isLoading(true);
      bool result = await _authService.register(
          createNameController.value.text,
          createEmailController.value.text,
          createPasswordController.value.text);
      if (result) {
        isLoading(false);
        isLogin(true);
        Get.snackbar(
          "Sucesso",
          "Conta criada com sucesso!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        isLoading(false);
        Get.snackbar(
          "Erro",
          "Erro ao criar conta!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void _showLoginFailedDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(Animations.error, width: 80, height: 80),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Login ou senha estão incorretos. Por favor, tente novamente.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                child: const Text("OK", style: TextStyle(color: Colors.blue)),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
