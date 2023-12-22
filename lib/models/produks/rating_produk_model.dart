import 'package:intravel_ease/models/user_model.dart';

class RatingProdukModel {
  final int? ratingpd_id;
  final int? ratingpd_idpengguna;
  final int? ratingpd_idproduk;
  final double? ratingpd_rating;
  final String? ratingpd_komentar;
  final String? created_at;
  final String? updated_at;
  final UserModel? user;

  RatingProdukModel({
    this.ratingpd_id,
    this.ratingpd_idpengguna,
    this.ratingpd_idproduk,
    this.ratingpd_rating,
    this.ratingpd_komentar,
    this.created_at,
    this.updated_at,
    this.user,
  });

  factory RatingProdukModel.fromJson(Map<String, dynamic> json) {
    return RatingProdukModel(
      ratingpd_id: json['ratingpd_id'],
      ratingpd_idpengguna: json['ratingpd_idpengguna'],
      ratingpd_idproduk: json['ratingpd_idproduk'],
      ratingpd_rating: double.parse(json['ratingpd_rating'].toString()),
      ratingpd_komentar: json['ratingpd_komentar'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
