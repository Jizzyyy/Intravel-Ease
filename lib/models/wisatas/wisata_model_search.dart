import 'package:intravel_ease/models/wisatas/wisata_image_model.dart';

class WisataModelSearch {
  final int? wisata_id;
  final String? wisata_nama;
  final String? wisata_tiket;
  final String? wisata_kontak;
  final String? wisata_deskripsi;
  final double? wisata_rating;
  final double? wisata_latitude;
  final double? wisata_longitude;
  final String? wisata_alamat;
  final String? wisata_kota;
  final String? wisata_provinsi;
  final int? wisata_active;
  final String? created_at;
  final String? updated_at;
  final WisataImageModel? image;

  WisataModelSearch({
    this.wisata_id,
    this.wisata_nama,
    this.wisata_tiket,
    this.wisata_kontak,
    this.wisata_deskripsi,
    this.wisata_rating,
    this.wisata_latitude,
    this.wisata_longitude,
    this.wisata_alamat,
    this.wisata_kota,
    this.wisata_provinsi,
    this.wisata_active,
    this.created_at,
    this.updated_at,
    this.image,
  });

  factory WisataModelSearch.fromJson(Map<String, dynamic> json) {
    double? dataku = null;
    if (json['wisata_rating'] != null) {
      dataku = double.parse(json['wisata_rating'].toString());
    }
    return WisataModelSearch(
      wisata_id: json['wisata_id'],
      wisata_nama: json['wisata_nama'],
      wisata_tiket: json['wisata_tiket'],
      wisata_kontak: json['wisata_kontak'],
      wisata_deskripsi: json['wisata_deskripsi'],
      wisata_rating: dataku,
      wisata_latitude: json['wisata_latitude'],
      wisata_longitude: json['wisata_longitude'],
      wisata_alamat: json['wisata_alamat'],
      wisata_kota: json['wisata_kota'],
      wisata_provinsi: json['wisata_provinsi'],
      wisata_active: json['wisata_active'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      image: WisataImageModel.fromJson(json['one_image']),
    );
  }
}
