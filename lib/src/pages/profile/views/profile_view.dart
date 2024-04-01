import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_app/src/components/social/social_media.dart';
import 'package:teste_app/src/components/text/custom_text.dart';
import 'package:teste_app/src/constants/colors.dart';
import 'package:teste_app/src/constants/images.dart';
import 'package:teste_app/src/constants/mixins/screen_utils.dart';
import 'package:teste_app/src/pages/profile/controllers/profile_controller.dart';
import 'package:teste_app/src/services/apis/auth/auth_service.dart';
import 'package:teste_app/src/services/navigation_service.dart';

class ProfileView extends GetView<ProfileController> with ScreenUtilityMixin {
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              _buildRoundedContainer(context, width, height),
              _buildAvatar(context, width, height),
              _buildActionButton(context, width, height),
              _buildCopy(context, height),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedContainer(
      BuildContext context, double width, double height) {
    return Positioned(
      top: 0,
      child: Container(
        width: width,
        height: height * 0.35,
        decoration: BoxDecoration(
          color: CustomColors.primaryColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, double width, double height) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(
          top: height * 0.1,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    border: Border.all(color: Colors.yellow, width: 2)),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40.0,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                '${controller.usuario.value?.name ?? 'Visitante'}!',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                controller.usuario.value?.email ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Componente do botão para sair do aplicativo
  Widget _buildActionButton(BuildContext context, double width, double height) {
    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.3,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  title: const Text('Confirmação'),
                  content: const Text(
                    'Você realmente deseja sair?',
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Customtext(
                        text: 'CANCELAR',
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    TextButton(
                      child: const Customtext(
                        text: 'SIM',
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        await AuthService().logout();
                        NavigationService.goToSplashAndRemoveEverything();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: width * 0.9,
            height: 60,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                blurRadius: 7,
                offset: const Offset(0, 3),
                spreadRadius: 0,
              ),
            ], borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: setWidth(16.0),
                        ),
                        const Text(
                          'Sair do Aplicativo',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      Images.icArrowNext,
                      width: 25,
                      height: 25,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCopy(BuildContext context, double height) {
    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.5,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.logoDefault,
              width: setWidth(40),
              color: CustomColors.primaryColor,
            ),
            SizedBox(
              width: setWidth(8.0),
            ),
            const Customtext(
              text: 'Tasker',
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ],
        ),
        SizedBox(
          height: setHeight(4.0),
        ),
        const Customtext(
          text: 'Desenvolvido por:',
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        Customtext(
          text: 'Rick Herson Batista Ramos',
          fontWeight: FontWeight.bold,
          color: CustomColors.primaryColor,
        ),
        SizedBox(
          height: setHeight(8.0),
        ),
        SocialMedia(controller: controller),
      ]),
    );
  }
}
