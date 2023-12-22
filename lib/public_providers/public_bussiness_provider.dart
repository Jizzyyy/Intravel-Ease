import 'package:flutter/material.dart';
import 'package:intravel_ease/models/usaha_model.dart';

class PublicBussinessProvider extends ChangeNotifier {
  UsahaModel? usahaModel;
  void setValues(UsahaModel usaha) {
    this.usahaModel = usaha;
    notifyListeners();
  }
  // int? usaha_id;
  // int? usaha_idpengguna;
  // int? usaha_idkategori;
  // String? usaha_nama;
  // String? usaha_produk;
  // String? usaha_kontak;
  // String? usaha_deskripsi;
  // String? usaha_gambar;
  // double? usaha_latitude;
  // double? usaha_longitude;
  // String? usaha_alamat;
  // String? usaha_kota;
  // String? usaha_provinsi;
  // int? usaha_active;
  // String? updated_at;
  // String? created_at;
  // void setValues({
  //   int? usaha_id,
  //   int? usaha_idpengguna,
  //   int? usaha_idkategori,
  //   String? usaha_nama,
  //   String? usaha_produk,
  //   String? usaha_kontak,
  //   String? usaha_deskripsi,
  //   String? usaha_gambar,
  //   double? usaha_latitude,
  //   double? usaha_longitude,
  //   String? usaha_alamat,
  //   String? usaha_kota,
  //   String? usaha_provinsi,
  //   int? usaha_active,
  //   String? updated_at,
  //   String? created_at,
  // }) {
  //   this.usaha_id = usaha_id;
  //   this.usaha_idpengguna = usaha_idpengguna;
  //   this.usaha_idkategori = usaha_idkategori;
  //   this.usaha_nama = usaha_nama;
  //   this.usaha_produk = usaha_produk;
  //   this.usaha_kontak = ;
  //   this.usaha_deskripsi;
  //   this.usaha_gambar;
  //   this.usaha_latitude;
  //   this.usaha_longitude;
  //   this.usaha_alamat;
  //   this.usaha_kota;
  //   this.usaha_provinsi;
  //   this.usaha_active;
  //   this.updated_at;
  //   this.created_at;
  //   notifyListeners();
  // }
}
