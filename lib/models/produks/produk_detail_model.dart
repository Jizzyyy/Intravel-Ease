import 'package:intravel_ease/models/usaha_model.dart';

class ProdukDetailModel {
  final int? produk_id;
  final int? produk_idusaha;
  final String? produk_nama;
  final int? produk_harga;
  final String? produk_gambar;
  final double? produk_rating;
  final int? produk_active;
  final String? created_at;
  final String? updated_at;
  final UsahaModel? usaha;

  ProdukDetailModel({
    this.produk_id,
    this.produk_idusaha,
    this.produk_nama,
    this.produk_harga,
    this.produk_gambar,
    this.produk_rating,
    this.produk_active,
    this.created_at,
    this.updated_at,
    this.usaha,
  });

  factory ProdukDetailModel.fromJson(Map<String, dynamic> json) {
    double? rating = null;
    if (json['produk_rating'] != null) {
      rating = double.tryParse(json['produk_rating'].toString());
    }
    return ProdukDetailModel(
      produk_id: json['produk_id'],
      produk_idusaha: json['produk_idusaha'],
      produk_nama: json['produk_nama'],
      produk_harga: json['produk_harga'],
      produk_gambar: json['produk_gambar'],
      produk_rating: rating,
      produk_active: json['produk_active'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      usaha: UsahaModel.fromJson(json['usaha']),
    );
  }
}
