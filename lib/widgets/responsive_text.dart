// import 'package:flutter/material.dart';

// class ResponsiveText extends StatelessWidget {
//   final String text;
//   final double widthFontSize;
//   final double heightFontSize;

//   ResponsiveText({
//     required this.text,
//     required this.widthFontSize,
//     required this.heightFontSize,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         final double screenWidth = constraints.maxWidth;
//         final double screenHeight = constraints.maxHeight;

//         print(screenWidth.toString() + 'ini width');
//         print(screenHeight.toString() + 'ini height');
//         final double fontSize =
//             (screenWidth < screenHeight) ? widthFontSize : heightFontSize;
//         print(fontSize.toString() + 'ini font size');
//         return Text(
//           text,
//           style: TextStyle(
//             fontSize: fontSize,
//           ),
//         );
//       },
//     );
//   }
// }
