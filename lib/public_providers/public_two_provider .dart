import 'package:flutter/cupertino.dart';

class PublicTwoProvider extends ChangeNotifier {
  String? one;
  String? two;

  void setValues({String? one, String? two}) {
    this.one = one;
    this.two = two;
    notifyListeners();
  }
}
