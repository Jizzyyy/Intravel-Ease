import 'package:intravel_ease/models/produks/produk_detail_model.dart';

class ResponseDetailProduk {
  final int? status;
  final String? title;
  final String? message;
  final ProdukDetailModel? data;

  ResponseDetailProduk({
    this.status,
    this.title,
    this.message,
    this.data,
  });

  factory ResponseDetailProduk.fromJson(Map<String, dynamic> json) {
    var dataku = null;
    if (json['data'] != null) {
      dataku = ProdukDetailModel.fromJson(json['data']);
    }
    return ResponseDetailProduk(
        status: json['status'],
        title: json['title'],
        message: json['message'],
        data: dataku);
  }
}
