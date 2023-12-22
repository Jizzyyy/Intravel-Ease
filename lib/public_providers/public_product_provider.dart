import 'package:flutter/foundation.dart';

class PublicProductProvider extends ChangeNotifier {
  String? idProduct;
  String? image;
  String? nama;
  String? harga;

  void setValues(
      {required String idProduct,
      required String image,
      required String nama,
      required String harga}) {
    this.idProduct = idProduct;
    this.image = image;
    this.nama = nama;
    this.harga = harga;
    notifyListeners();
  }
}
