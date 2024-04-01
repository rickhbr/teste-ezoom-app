import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teste_app/src/components/text/custom_text.dart';
import 'package:teste_app/src/constants/colors.dart';
import 'package:teste_app/src/constants/icons.dart';
import 'package:teste_app/src/constants/mixins/screen_utils.dart';

class CustomButton extends StatefulWidget {
  final void Function()? onTap;
  final double? width;
  final double? height;
  final String labelButton;
  final bool hasIcon;
  final Color? color;

  const CustomButton(
      {super.key,
      this.width,
      this.height,
      required this.labelButton,
      this.hasIcon = false,
      this.color,
      this.onTap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with ScreenUtilityMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width ?? setWidth(160),
        height: widget.height ?? setHeight(40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.color ?? CustomColors.primaryColor),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Customtext(
                text: widget.labelButton,
                fontSize: setFontSize(14),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(
                width: setWidth(8.0),
              ),
              widget.hasIcon
                  ? SvgPicture.asset(IconsApp.icArrowNext)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
