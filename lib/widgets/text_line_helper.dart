// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LineTextHelper extends StatefulWidget {
  final text;
  final fontSize;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  Color? fontColor;
  String? fontFamily;
  final TextDecoration? textDecoration;
  int? maxLines;
  TextOverflow? overflow;

  LineTextHelper({
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

  @override
  _LineTextHelperState createState() => _LineTextHelperState();
}

class _LineTextHelperState extends State<LineTextHelper> {
  bool _isMultiLine = false;

  @override
  void initState() {
    super.initState();
    _isMultiLine = widget.text.contains('\n');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final textSpan = TextSpan(
          text: widget.text,
          style: DefaultTextStyle.of(context).style,
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: 1,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);

        final isTextOverflow = textPainter.didExceedMaxLines;

        if (_isMultiLine || !isTextOverflow) {
          return Column(
            children: [
              Text(
                widget.text,
                textAlign: widget.textAlign,
                maxLines: widget.maxLines,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  fontFamily: widget.fontFamily ?? 'nunito-sm',
                  fontWeight: widget.fontWeight,
                  color: widget.fontColor,
                  overflow: widget.overflow,
                  decoration: widget.textDecoration,
                  height: 0,
                  // color: fontColor,
                ),
              ),
              Text(
                '',
                style: TextStyle(
                    fontSize: widget.fontSize, fontFamily: widget.fontFamily),
              ),
            ],
          );
        } else {
          return Text(
            widget.text,
            textAlign: widget.textAlign,
            maxLines: widget.maxLines,
            style: TextStyle(
              fontSize: widget.fontSize,
              fontFamily: widget.fontFamily ?? 'nunito-sm',
              fontWeight: widget.fontWeight,
              color: widget.fontColor,
              overflow: widget.overflow,
              decoration: widget.textDecoration,
              // color: fontColor,
            ),
          );
        }
      },
    );
  }
}
