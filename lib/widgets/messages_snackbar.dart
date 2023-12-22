import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class MessagesSnacbar {
  static void success(BuildContext context, String message) {
    AnimatedSnackBar.material(
      '${message}',
      type: AnimatedSnackBarType.success,
      duration: const Duration(seconds: 4),
      desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
    ).show(context);
  }

  static void error(BuildContext context, String message) {
    AnimatedSnackBar.material(
      '${message}',
      type: AnimatedSnackBarType.error,
      duration: const Duration(seconds: 4),
      desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
    ).show(context);
  }

  static void warning(BuildContext context, String message) {
    AnimatedSnackBar.material(
      '${message}',
      type: AnimatedSnackBarType.warning,
      duration: const Duration(seconds: 4),
      desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
    ).show(context);
  }
}
