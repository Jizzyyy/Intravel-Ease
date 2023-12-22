import 'package:intravel_ease/models/rating_wisata_model.dart';

class ResponseRatingWisata {
  final int? status;
  final String? title;
  final String? message;
  final List<RatingWisataModel>? data;

  ResponseRatingWisata({
    this.status,
    this.title,
    this.message,
    this.data,
  });

  factory ResponseRatingWisata.fromJson(Map<String, dynamic> json) {
    List<RatingWisataModel> fillData = [];
    if (json['data'] != null) {
      fillData = json['data']
          .map<RatingWisataModel>((json) => RatingWisataModel.fromJson(json))
          .toList();
    }
    return ResponseRatingWisata(
      status: json['status'],
      title: json['title'],
      message: json['message'],
      data: fillData,
    );
  }
}
