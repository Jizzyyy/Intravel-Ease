import 'package:flutter/cupertino.dart';

class PublicOneProvider extends ChangeNotifier {
  String? one;

  void setValues({String? one}) {
    this.one = one;
    notifyListeners();
  }
}
