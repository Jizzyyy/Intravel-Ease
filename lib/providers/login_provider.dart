import 'dart:convert';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intravel_ease/controllers/user_controller.dart';
import 'package:intravel_ease/screens/navigation_screen.dart';
import 'package:page_transition/page_transition.dart';

class LoginProvider extends ChangeNotifier {
  bool _isPasswordVisible = true;
  double _topPositioned = 100;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool get isPasswordVisible => _isPasswordVisible;
  double get getTopPositioned => _topPositioned;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void animatedPositioned() {
    _topPositioned = 0;
    notifyListeners();
  }

  void buttonLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      UserController.loginUser(
              context, emailController.text, passwordController.text)
          .then((value) async {
        if (value!.status! >= 400) {
          AnimatedSnackBar.rectangle(value.title!, value.message!,
                  type: AnimatedSnackBarType.error)
              .show(context);
        } else {
          const storage = FlutterSecureStorage();
          String jsonString = json.encode(value.data?.toJson());
          await storage.write(key: 'user_data', value: jsonString);
          await storage.write(key: 'token', value: value.token);
          await storage.write(key: 'log_status', value: 'true');
          await Navigator.of(context).pushAndRemoveUntil(
              PageTransition(
                  child: const NavigationScreen(),
                  reverseDuration: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 500),
                  alignment: Alignment.bottomCenter,
                  type: PageTransitionType.size),
              (route) => false);
        }
      });
    }
    notifyListeners();
  }
}
