import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_app/src/components/button/custom_button.dart';
import 'package:teste_app/src/components/divider/diveder_or.dart';
import 'package:teste_app/src/components/forms_field/custom_form_field.dart';
import 'package:teste_app/src/components/forms_field/custom_form_field_title.dart';
import 'package:teste_app/src/components/loading/loading.dart';
import 'package:teste_app/src/components/text/custom_text.dart';
import 'package:teste_app/src/constants/colors.dart';
import 'package:teste_app/src/constants/images.dart';
import 'package:teste_app/src/constants/mixins/screen_utils.dart';
import 'package:teste_app/src/constants/validators.dart';
import 'package:teste_app/src/pages/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> with ScreenUtilityMixin {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Loading(
          show: controller.isLoading.value,
          child: PopScope(
            canPop: false,
            child: Scaffold(
                resizeToAvoidBottomInset: false, body: _buildBody(context)),
          )),
    );
  }

  Widget _buildBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      width: width,
      height: height,
      child: Stack(
        children: [
          _buildRoundedContainer(context, width, height),
          _buildContainerInput(context),
          _buildLogo(context),
        ],
      ),
    );
  }

  Widget _buildRoundedContainer(
      BuildContext context, double width, double height) {
    return Positioned(
      top: 0,
      child: Container(
        width: width,
        height: height * 0.4,
        decoration: BoxDecoration(
          color: CustomColors.primaryColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: setHeight(100),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logoHero',
              child: Image.asset(
                Images.logoDefault,
                width: setWidth(80),
              ),
            ),
            SizedBox(
              width: setWidth(16.0),
            ),
            Customtext(
              text: 'Tasker',
              fontSize: setFontSize(26),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContainerInput(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(top: setHeight(100.0)),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: controller.isLogin.value ? setHeight(400) : setHeight(430),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(
                  top: setHeight(24.0),
                  left: setWidth(28.0),
                  right: setWidth(28.0),
                ),
                child: _buildInputs(width)),
          ),
        ),
      ),
    );
  }

  Widget _buildInputs(double width) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Customtext(
              text: 'Olá, Bem vindo!',
              fontSize: setFontSize(20),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            Customtext(
              text: 'Por favor entre na sua conta.',
              fontSize: setFontSize(14),
              fontWeight: FontWeight.normal,
              color: Colors.grey.shade500,
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              child: controller.isLogin.value
                  ? _buildLogin(width)
                  : _buildRegister(width),
            ),
            SizedBox(
              height: setHeight(24.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegister(double width) {
    return Form(
      key: controller.registerFormKey,
      child: Column(
        key: const ValueKey('registerView'),
        children: [
          SizedBox(
            height: setHeight(32.0),
          ),
          CustomFormFieldTitle(
            controller: controller.createNameController.value,
            titleInput: 'Nome e sobrenome',
            hintText: 'Seu nome',
            icon: Icons.person,
            validator: FieldValidators.nameValidator,
          ),
          SizedBox(height: setHeight(10.0)),
          CustomFormFieldTitle(
            controller: controller.createEmailController.value,
            titleInput: 'E-mail',
            hintText: 'Seu e-mail',
            icon: Icons.email_outlined,
            validator: FieldValidators.emailValidator,
          ),
          SizedBox(height: setHeight(10.0)),
          CustomFormFieldTitle(
            controller: controller.createPasswordController.value,
            titleInput: 'Crie uma senha',
            hintText: 'Sua senha',
            icon: Icons.key,
            isPassword: true,
            validator: FieldValidators.passwordValidator,
          ),
          SizedBox(height: setHeight(32.0)),
          _buildRegisterRow(),
        ],
      ),
    );
  }

  Widget _buildLogin(double width) {
    return Form(
      key: controller.loginFormKey,
      child: Column(
        key: const ValueKey('loginView'),
        children: [
          SizedBox(
            height: setHeight(
              12.0,
            ),
          ),
          _buildCreateAccount(),
          SizedBox(
            height: setHeight(
              24.0,
            ),
          ),
          const DividerOr(),
          SizedBox(
            height: setHeight(
              24.0,
            ),
          ),
          CustomFormField(
            controller: controller.emailController.value,
            hintText: 'Digite o e-mail',
            icon: Icons.email_outlined,
            validator: FieldValidators.emailValidator,
          ),
          SizedBox(
            height: setHeight(
              8.0,
            ),
          ),
          CustomFormField(
            controller: controller.passwordController.value,
            hintText: 'Sua senha',
            icon: Icons.key,
            isPassword: true,
            validator: FieldValidators.passwordValidator,
          ),
          SizedBox(
            height: setHeight(32.0),
          ),
          _buildLoginRow(),
        ],
      ),
    );
  }

  Widget _buildCreateAccount() {
    return Row(
      children: [
        Customtext(
          text: 'Não tem uma conta? ',
          fontSize: setFontSize(14),
          fontWeight: FontWeight.normal,
          color: Colors.grey.shade500,
        ),
        GestureDetector(
          onTap: () {
            controller.handleLogin();
          },
          child: Customtext(
            text: 'Criar uma',
            fontSize: setFontSize(14),
            fontWeight: FontWeight.bold,
            color: CustomColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            controller.handleLogin();
          },
          child: Customtext(
            text: 'Voltar',
            fontSize: setFontSize(14),
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade500,
          ),
        ),
        SizedBox(
          width: setWidth(8.0),
        ),
        CustomButton(
          onTap: () async {
            if (controller.validateRegisterForm()) {
              await controller.attemptRegister();
            }
          },
          labelButton: 'CADASTRAR',
          hasIcon: true,
        ),
      ],
    );
  }

  Widget _buildLoginRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Customtext(
          text: 'Esqueceu a senha?',
          fontSize: setFontSize(14),
          fontWeight: FontWeight.normal,
          color: Colors.grey.shade500,
        ),
        SizedBox(
          width: setWidth(8.0),
        ),
        CustomButton(
          onTap: () async {
            if (controller.validateLoginForm()) {
              await controller.attemptLogin();
            }
          },
          labelButton: 'ENTRAR',
          width: setWidth(130),
          height: setHeight(40),
          hasIcon: true,
        )
      ],
    );
  }
}
