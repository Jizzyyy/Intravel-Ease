import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intravel_ease/configs/secure_data.dart';
import 'package:intravel_ease/controllers/usaha_controller.dart';
import 'package:intravel_ease/models/usaha_model.dart';
import 'package:intravel_ease/models/user_model.dart';
import 'package:intravel_ease/public_providers/public_bussiness_provider.dart';
import 'package:intravel_ease/screens/add_bussiness_screen.dart';
import 'package:intravel_ease/screens/manage_bussiness_screen.dart';
import 'package:intravel_ease/screens/blocked_bussiness_screen.dart';
import 'package:intravel_ease/screens/waiting_acc_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../screens/lock_screen.dart';

class SettingProvider extends ChangeNotifier {
  String? nama;
  String? email;
  String? gambar;

  buttonLogout(BuildContext context) async {
    final storage = FlutterSecureStorage();
    Map<String, String> allValues = await storage.readAll();
    for (var key in allValues.keys) {
      await storage.delete(key: key);
    }
    await Navigator.of(context).push(PageTransition(
        child: const LockScreen(),
        reverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.bottomCenter,
        type: PageTransitionType.size));
  }

  void buttonManange(BuildContext context) {
    try {
      EasyLoading.show();
      UsahaController.checkUsaha().then((value) {
        EasyLoading.dismiss();
        if (value!.status == 200) {
          UsahaModel? usaha = value.data ?? null;
          Provider.of<PublicBussinessProvider>(context, listen: false)
              .setValues(usaha!);
          if (value.data!.usaha_active == 'BELUM DISETUJUI') {
            Navigator.of(context).push(
              PageTransition(
                  child: const WaitingAccScreen(),
                  reverseDuration: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 500),
                  alignment: Alignment.bottomCenter,
                  type: PageTransitionType.size),
            );
          } else if (value.data!.usaha_active == 'DISETUJUI') {
            Navigator.of(context).push(
              PageTransition(
                  child: const ManageBussinessScreen(),
                  reverseDuration: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 500),
                  alignment: Alignment.bottomCenter,
                  type: PageTransitionType.size),
            );
          } else if (value.data!.usaha_active == 'DIBLOKIR') {
            Navigator.of(context).push(
              PageTransition(
                  child: const BlockedBussinessScreen(),
                  reverseDuration: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 500),
                  alignment: Alignment.bottomCenter,
                  type: PageTransitionType.size),
            );
          } else {
            Navigator.of(context).push(
              PageTransition(
                  child: const BlockedBussinessScreen(),
                  reverseDuration: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 500),
                  alignment: Alignment.bottomCenter,
                  type: PageTransitionType.size),
            );
          }
        } else {
          Navigator.of(context).push(
            PageTransition(
                child: const AddBussinessScreen(),
                reverseDuration: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 500),
                alignment: Alignment.bottomCenter,
                type: PageTransitionType.size),
          );
        }
      });
    } catch (e) {
      print('error : $e');
    }
  }

  void tampilData() async {
    UserModel user = await SecureData.getUserData();
    nama = user.user_nama;
    email = user.user_email;
    gambar = user.user_foto;
    notifyListeners();
  }
}
