// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../configs/app_color.dart';

class PasswordFieldHelper extends StatelessWidget {
  PasswordFieldHelper({
    required this.hintText,
    required this.borderRadius,
    required this.suffixOnTap,
    required this.obscureText,
    this.prefixIcon,
    this.fillColor,
    this.borderSide,
    this.textStyle,
    this.labelText,
    this.filled,
    this.controller,
    this.inputFormatter,
    this.validator,
    Key? key,
  }) : super(key: key);
  String hintText;
  double borderRadius;
  Icon? prefixIcon;
  Color? fillColor;
  BorderSide? borderSide;
  bool obscureText;
  TextStyle? textStyle;
  bool? filled;
  String? labelText;
  VoidCallback suffixOnTap;
  TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatter;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: GestureDetector(
            onTap: suffixOnTap,
            child: obscureText == true
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: borderSide ?? BorderSide.none,
        ),
        filled: filled ?? true,
        labelText: labelText,
        hintText: hintText,
        fillColor: fillColor ?? AppColors.inputgrey,
      ),
      validator: validator,
      inputFormatters: inputFormatter,
      style: textStyle ?? TextStyle(fontSize: 17.sp, color: AppColors.black),
    );
  }
}
