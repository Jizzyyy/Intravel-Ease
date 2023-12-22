import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextHelper extends StatelessWidget {
  TextHelper({
    required this.text,
    required this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.fontColor,
    this.textAlign,
    this.textDecoration,
    this.maxLines,
    this.overflow,
    Key? key,
  }) : super(key: key);

  final text;
  final fontSize;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  Color? fontColor;
  String? fontFamily;
  final TextDecoration? textDecoration;
  int? maxLines;
  TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily ?? 'nunito-sm',
        fontWeight: fontWeight,
        color: fontColor,
        overflow: overflow,
        decoration: textDecoration,
        // color: fontColor,
      ),
    );
  }
}
