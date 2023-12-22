import 'package:intravel_ease/models/rating_wisata_model.dart';
import 'package:intravel_ease/models/wisatas/wisata_model_detail.dart';

class ResponseWisataDetail {
  final int? status;
  final String? title;
  final String? message;
  final WisataModelDetail? data;
  final RatingWisataModel? review;

  ResponseWisataDetail({
    this.status,
    this.title,
    this.message,
    this.data,
    this.review,
  });

  factory ResponseWisataDetail.fromJson(Map<String, dynamic> json) {
    var fillData = null;
    var reviewData = null;
    if (json['data'] != null) {
      fillData = WisataModelDetail.fromJson(json['data']);
    }
    if (json['review'] != null) {
      reviewData = RatingWisataModel.fromJson(json['review']);
    }

    return ResponseWisataDetail(
      status: json['status'],
      title: json['title'],
      message: json['message'],
      data: fillData,
      review: reviewData,
    );
  }
}
