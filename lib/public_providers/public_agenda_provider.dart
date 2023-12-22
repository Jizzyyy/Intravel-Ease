import 'package:flutter/foundation.dart';

class PublicAgendaProvider extends ChangeNotifier {
  String? id;
  int? inc;
  String? kategori;
  String? namaWisata;
  String? deskripsi;
  String? tanggal;
  String? jamMulai;
  String? jamSelesai;
  String? warna;

  void setValues(
    String id,
    int inc,
    String kategori,
    String namaWisata,
    String deskripsi,
    String tanggal,
    String jamMulai,
    String jamSelesai,
    String warna,
  ) {
    this.id = id;
    this.inc = inc;
    this.kategori = kategori;
    this.namaWisata = namaWisata;
    this.deskripsi = deskripsi;
    this.tanggal = tanggal;
    this.jamMulai = jamMulai;
    this.jamSelesai = jamSelesai;
    this.warna = warna;
  }
}
