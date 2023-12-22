import '../models/produks/produk_model.dart';

class ResponseProduk {
  final int? status;
  final String? title;
  final String? message;
  final List<ProdukModel>? data;

  ResponseProduk({
    this.status,
    this.title,
    this.message,
    this.data,
  });

  factory ResponseProduk.fromJson(Map<String, dynamic> json) {
    List<ProdukModel> produkData = [];
    if (json['data'] != null) {
      produkData = json['data']
          .map<ProdukModel>((json) => ProdukModel.fromJson(json))
          .toList();
    }

    return ResponseProduk(
      status: json['status'],
      title: json['title'],
      message: json['message'],
      data: produkData,
    );
  }
}
