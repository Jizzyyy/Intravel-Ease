import 'package:flutter/material.dart';

class PublicAddBussinessProvider extends ChangeNotifier {
  String? latitude;
  String? longitude;
  String? alamat;
  String? kota;
  String? provinsi;
  void setValues(
      {String? latitude,
      String? longitude,
      String? alamat,
      String? kota,
      String? provinsi}) {
    this.latitude = latitude;
    this.longitude = longitude;
    this.alamat = alamat;
    this.kota = kota;
    this.provinsi = provinsi;
    notifyListeners();
  }
}
