import 'package:flutter/foundation.dart';

class PublicRegisterProvider extends ChangeNotifier {
  String? nama;
  String? email;
  String? password;

  void setValues({String? nama, String? email, String? password}) {
    this.nama = nama;
    this.email = email;
    this.password = password;
    notifyListeners();
  }
}
