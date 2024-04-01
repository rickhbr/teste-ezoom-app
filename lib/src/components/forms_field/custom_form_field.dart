import 'package:flutter/material.dart';
import 'package:teste_app/src/constants/colors.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final String? Function(String?)? validator;
  const CustomFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isObscured = false;

  @override
  void initState() {
    isObscured = widget.isPassword;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: widget.controller,
      obscureText: isObscured,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(widget.icon, color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                color: CustomColors.primaryColor,
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
                icon: isObscured
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              )
            : null,
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
