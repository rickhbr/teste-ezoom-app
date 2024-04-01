import 'package:flutter/material.dart';
import 'package:teste_app/src/components/forms_field/custom_form_field.dart';
import 'package:teste_app/src/components/text/custom_text.dart';
import 'package:teste_app/src/constants/mixins/screen_utils.dart';

class CustomFormFieldTitle extends StatelessWidget with ScreenUtilityMixin {
  final String titleInput;
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;
  final String? Function(String?)? validator;
  const CustomFormFieldTitle(
      {super.key,
      required this.titleInput,
      required this.hintText,
      required this.controller,
      required this.icon,
      this.isPassword = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Customtext(
          text: titleInput,
          fontSize: setFontSize(14),
          fontWeight: FontWeight.normal,
          color: Colors.grey.shade500,
        ),
        CustomFormField(
          controller: controller,
          hintText: hintText,
          icon: icon,
          isPassword: isPassword,
          validator: validator,
        ),
      ],
    );
  }
}
