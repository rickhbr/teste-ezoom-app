import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customtext extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  const Customtext(
      {super.key,
      required this.text,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            color: color ?? Colors.white,
            fontSize: fontSize ?? 16.0,
            fontWeight: fontWeight ?? FontWeight.normal),
      ),
    );
  }
}
