import 'package:intravel_ease/models/produks/rating_produk_model.dart';

class ResponseRatingProduk {
  final int? status;
  final String? title;
  final String? message;
  final List<RatingProdukModel>? data;

  ResponseRatingProduk({
    this.status,
    this.title,
    this.message,
    this.data,
  });

  factory ResponseRatingProduk.fromJson(Map<String, dynamic> json) {
    List<RatingProdukModel> fillData = [];
    if (json['data'] != null) {
      fillData = json['data']
          .map<RatingProdukModel>((json) => RatingProdukModel.fromJson(json))
          .toList();
    }
    return ResponseRatingProduk(
      status: json['status'],
      title: json['title'],
      message: json['message'],
      data: fillData,
    );
  }
}
