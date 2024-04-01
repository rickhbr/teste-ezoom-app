import 'package:flutter/material.dart';
import 'package:teste_app/src/constants/images.dart';
import 'package:teste_app/src/constants/mixins/screen_utils.dart';
import 'package:teste_app/src/pages/profile/controllers/profile_controller.dart';

class SocialMedia extends StatelessWidget with ScreenUtilityMixin {
  final ProfileController controller;
  const SocialMedia({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => controller.launchUrlSocial('https://github.com/rickhbr'),
          child: Image.asset(
            Images.logoGit,
            width: setWidth(30),
          ),
        ),
        SizedBox(
          width: setWidth(16.0),
        ),
        GestureDetector(
          onTap: () => controller.launchUrlSocial(
              'https://www.linkedin.com/in/rick-ramos-00a94a138/'),
          child: Image.asset(
            Images.logoLinkedin,
            width: setWidth(30),
          ),
        ),
        SizedBox(
          width: setWidth(16.0),
        ),
        GestureDetector(
          onTap: () =>
              controller.launchUrlSocial('https://wa.me/5592984825832'),
          child: Image.asset(
            Images.logoWpp,
            width: setWidth(30),
          ),
        ),
      ],
    );
  }
}
