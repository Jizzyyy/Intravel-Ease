import 'dart:convert';

import 'package:intravel_ease/responses/response_rating_wisata.dart';
import 'package:http/http.dart' as http;
import '../configs/api_util.dart';
import '../configs/secure_data.dart';

class RatingWisataController {
  static Future<ResponseRatingWisata?> getPaginate(String idWisata) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/ratingws/paginate/$idWisata');
      var response = await http.get(url, headers: await SecureData.getToken());
      var wisataData = json.decode(response.body);
      return ResponseRatingWisata.fromJson(wisataData);
    } catch (e) {
      print('Error adalah : $e');
      return null;
    }
  }

  static Future<ResponseRatingWisata?> filterReview(
      String idWisata, String rating) async {
    try {
      Uri url =
          Uri.parse(ApiUtil.urlBase + 'api/ratingws/filter/$idWisata/$rating');
      var response = await http.get(url, headers: await SecureData.getToken());
      var wisataData = json.decode(response.body);
      return ResponseRatingWisata.fromJson(wisataData);
    } catch (e) {
      print('Error adalah : $e');
      return null;
    }
  }

  static Future<ResponseRatingWisata?> addReview(String idPengguna,
      String idWisata, double rating, String komentar) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/ratingws/add');
      var response =
          await http.post(url, headers: await SecureData.getToken(), body: {
        'ratingws_idpengguna': idPengguna,
        'ratingws_idwisata': idWisata,
        'ratingws_rating': rating.toString(),
        'ratingws_komentar': komentar,
      });
      var wisataData = json.decode(response.body);
      return ResponseRatingWisata.fromJson(wisataData);
    } catch (e) {
      print('Error adalah : $e');
      return null;
    }
  }
}
