import 'package:intravel_ease/models/user_model.dart';

class RatingWisataModel {
  final int? ratingws_id;
  final int? ratingws_idpengguna;
  final int? ratingws_idwisata;
  final double? ratingws_rating;
  final String? ratingws_komentar;
  final String? created_at;
  final String? updated_at;
  final UserModel? user;

  RatingWisataModel({
    this.ratingws_id,
    this.ratingws_idpengguna,
    this.ratingws_idwisata,
    this.ratingws_rating,
    this.ratingws_komentar,
    this.created_at,
    this.updated_at,
    this.user,
  });

  factory RatingWisataModel.fromJson(Map<String, dynamic> json) {
    var fillData = null;
    if (json['user'] != null) {
      fillData = UserModel.fromJson(json['user']);
    }
    return RatingWisataModel(
      ratingws_id: json['ratingws_id'],
      ratingws_idpengguna: json['ratingws_idpengguna'],
      ratingws_idwisata: json['ratingws_idwisata'],
      ratingws_rating: double.parse(json['ratingws_rating'].toString()),
      ratingws_komentar: json['ratingws_komentar'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      user: fillData,
    );
  }
}
