import 'dart:convert';

import 'package:intravel_ease/responses/response_rating_produk.dart';
import 'package:intravel_ease/responses/response_rating_wisata.dart';
import 'package:http/http.dart' as http;
import '../configs/api_util.dart';
import '../configs/secure_data.dart';

class RatingProdukController {
  static Future<ResponseRatingProduk?> getPaginate(String idProduk) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/ratingpd/paginate/$idProduk');
      var response = await http.get(url, headers: await SecureData.getToken());
      var produkData = json.decode(response.body);
      return ResponseRatingProduk.fromJson(produkData);
    } catch (e) {
      print('Error adalah : $e');
      return null;
    }
  }

  static Future<ResponseRatingProduk?> filterReview(
      String idProduk, String rating) async {
    try {
      Uri url =
          Uri.parse(ApiUtil.urlBase + 'api/ratingpd/filter/$idProduk/$rating');
      var response = await http.get(url, headers: await SecureData.getToken());
      var wisataData = json.decode(response.body);
      print(wisataData);
      return ResponseRatingProduk.fromJson(wisataData);
    } catch (e) {
      print('Error adalah : $e');
      return null;
    }
  }

  static Future<ResponseRatingProduk?> addReview(String idPengguna,
      String idProduk, double rating, String komentar) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/ratingpd/add');
      var response =
          await http.post(url, headers: await SecureData.getToken(), body: {
        'ratingpd_idpengguna': idPengguna,
        'ratingpd_idproduk': idProduk,
        'ratingpd_rating': rating.toString(),
        'ratingpd_komentar': komentar,
      });
      var wisataData = json.decode(response.body);
      return ResponseRatingProduk.fromJson(wisataData);
    } catch (e) {
      print('Error adalah : $e');
      return null;
    }
  }
}
