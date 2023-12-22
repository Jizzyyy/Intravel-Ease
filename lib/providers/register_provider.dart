import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intravel_ease/screens/verification_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../public_providers/public_register_provider.dart';

class RegisterProvider extends ChangeNotifier {
  bool passwordVisible = true;
  bool confirmVisible = true;

  TextEditingController? namaController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmpasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool get isPasswordVisible => passwordVisible;
  bool get isConfirmVisible => confirmVisible;

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void toggleConfirmVisibility() {
    confirmVisible = !confirmVisible;
    notifyListeners();
  }

  String? validatorNama(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'Nama tidak boleh kosong.';
    }
    return null;
  }

  String? validatorEmail(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'Email tidak boleh kosong.';
    }
    return null;
  }

  String? validatorPassword(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'Password tidak boleh kosong.';
    } else if (fieldContent.length < 8) {
      return 'Password minimal 8 karakter.';
    }
    return null;
  }

  String? validatorConfirm(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'Masukkan kembali password anda.';
    }
    return null;
  }

  void buttonRegister(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (confirmpasswordController!.text != passwordController!.text) {
        AnimatedSnackBar.material(
          'Konfirmasi kata sandi salah!',
          type: AnimatedSnackBarType.error,
        ).show(context);
      } else {
        Provider.of<PublicRegisterProvider>(context, listen: false).setValues(
          nama: namaController!.text,
          email: emailController!.text,
          password: passwordController!.text,
        );
        Navigator.of(context).push(PageTransition(
            child: const VerificationScreen(),
            reverseDuration: const Duration(milliseconds: 200),
            duration: const Duration(milliseconds: 500),
            alignment: Alignment.bottomCenter,
            type: PageTransitionType.size));
      }
    }
    notifyListeners();
  }
}
