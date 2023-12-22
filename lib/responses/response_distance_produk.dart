import 'package:intravel_ease/models/produks/produk_distance_model.dart';

class ResponseDistanceProduk {
  final int? status;
  final String? title;
  final String? message;
  final List<ProdukDistanceModel>? data;

  ResponseDistanceProduk({
    this.status,
    this.title,
    this.message,
    this.data,
  });

  factory ResponseDistanceProduk.fromJson(Map<String, dynamic> json) {
    List<ProdukDistanceModel> produkData = [];
    if (json['data'] != null) {
      produkData = json['data']
          .map<ProdukDistanceModel>(
              (json) => ProdukDistanceModel.fromJson(json))
          .toList();
    }
    return ResponseDistanceProduk(
      status: json['status'],
      title: json['title'],
      message: json['message'],
      data: produkData,
    );
  }
}
