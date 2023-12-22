import 'package:flutter/cupertino.dart';

class PublicDistanceProvider extends ChangeNotifier {
  String? latitude;
  String? longitude;

  void setValues({String? latitude, String? longitude}) {
    this.latitude = latitude;
    this.longitude = longitude;
    notifyListeners();
  }
}
