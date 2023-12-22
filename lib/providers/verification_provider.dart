import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intravel_ease/controllers/user_controller.dart';
import 'package:intravel_ease/public_providers/public_register_provider.dart';
import 'package:intravel_ease/screens/navigation_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class VerificationProvider extends ChangeNotifier {
  EmailOTP? myauth = EmailOTP();
  TextEditingController otpController = new TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> sendOtp(BuildContext context) async {
    final publicRegister =
        Provider.of<PublicRegisterProvider>(context, listen: false);
    await Future.delayed(Duration(seconds: 2));
    myauth = EmailOTP();
    myauth!.setConfig(
        appEmail: "kadhafinaufal2@gmail.com",
        appName: "InTravel Ease",
        userEmail: publicRegister.email,
        otpLength: 4,
        otpType: OTPType.digitsOnly);
    bool isOtpSent = await myauth!.sendOTP();
    if (isOtpSent) {
      await myauth!.setSMTP(
        host: "smtp.gmail.com",
        auth: true,
        username: "intraveleasev@gmail.com",
        password: "fikyeusxrfmhnbhx",
        secure: "TLS",
        port: 587,
      );
    }
    return isOtpSent;
  }

  void init() {}

  void buttonSend(BuildContext context) async {
    bool cobaDulu = false;
    EasyLoading.show();
    await sendOtp(context).then((value) => cobaDulu = value);
    if (cobaDulu) {
      if (scaffoldKey.currentContext != null) {
        AnimatedSnackBar.rectangle(
          'Sukses',
          'Kode OTP Berhasil Dikirim',
          type: AnimatedSnackBarType.success,
          brightness: Brightness.light,
        ).show(context);
      }
    } else {
      if (scaffoldKey.currentContext != null) {
        AnimatedSnackBar.rectangle(
          'Gagal',
          'Kode OTP Gagal Dikirim',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.light,
        ).show(context);
      }
    }
    EasyLoading.dismiss();
  }

  void buttonVerifikasi(BuildContext context) async {
    // try {
    if (await myauth!.verifyOTP(otp: otpController.text) == true) {
      final publicRegister =
          Provider.of<PublicRegisterProvider>(context, listen: false);
      UserController.registerUser(
              context,
              publicRegister.nama.toString(),
              publicRegister.email.toString(),
              publicRegister.password.toString())
          .then((value) async {
        if (value!.status! >= 400) {
          AnimatedSnackBar.rectangle(
                  value!.title.toString(), value!.message.toString(),
                  type: AnimatedSnackBarType.error,
                  brightness: Brightness.light)
              .show(context);
        } else {
          const storage = FlutterSecureStorage();
          String jsonString = json.encode(value!.data?.toJson());
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
    } else {
      AnimatedSnackBar.rectangle('Error', 'Kode OTP tidak cocok',
              type: AnimatedSnackBarType.error, brightness: Brightness.light)
          .show(context);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text("Invalid OTP"),
      // ));
    }
  }
}
