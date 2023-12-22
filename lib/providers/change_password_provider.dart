import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intravel_ease/configs/secure_data.dart';
import 'package:intravel_ease/controllers/user_controller.dart';
import 'package:intravel_ease/models/user_model.dart';

import '../widgets/messages_snackbar.dart';

class ChangePasswordProvider extends ChangeNotifier {
  TextEditingController sandiLamaController = TextEditingController();
  TextEditingController sandiBaruController = TextEditingController();
  TextEditingController konfirmSandiController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  void changePassword(BuildContext context) async {
    UserModel dataku = await SecureData.getUserData();
    if (formKey.currentState!.validate()) {
      if (sandiBaruController.text != konfirmSandiController.text) {
        if (scaffoldKey.currentContext != null)
          MessagesSnacbar.warning(
              context, 'Kata sandi baru dan konfirmasi kata sandi tidak sama');
      } else {
        EasyLoading.show();
        final value = await UserController.changePassword(
            context,
            dataku.user_email,
            sandiLamaController.text,
            sandiBaruController.text);
        EasyLoading.dismiss();
        if (value?.status == 200) {
          if (scaffoldKey.currentContext != null)
            MessagesSnacbar.success(context, 'Kata sandi berhasil diubah');
        } else {
          if (scaffoldKey.currentContext != null)
            MessagesSnacbar.error(context, value!.title.toString());
        }
      }
    }
  }
}
