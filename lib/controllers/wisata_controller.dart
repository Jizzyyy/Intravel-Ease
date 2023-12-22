import 'dart:convert';
import 'package:intravel_ease/configs/api_util.dart';
import 'package:http/http.dart' as http;
import 'package:intravel_ease/configs/secure_data.dart';
import 'package:intravel_ease/models/user_model.dart';
import 'package:intravel_ease/responses/response_wisata_distance.dart';
import 'package:intravel_ease/responses/response_wisata_search.dart';

import '../responses/response_wisata_detail.dart';

class WisataController {
  static Future<ResponseWisataDistance?> getWisataDistance(
      double latitude, double longitude) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/wisata/terdekat');
      var response = await http.post(url,
          body: {
            'wisata_latitude': latitude.toString(),
            'wisata_longitude': longitude.toString(),
          },
          headers: await SecureData.getToken());
      var wisataData = json.decode(response.body);
      return ResponseWisataDistance.fromJson(wisataData);
    } catch (e) {
      print('Error wisata home distance adalah : $e');
      return null;
    }
  }

  static Future<ResponseWisataDistance?> getWisataFilterDistance(
      String latitude, String longitude, String filter) async {
    try {
      Uri url = Uri.parse(
          ApiUtil.urlBase + 'api/wisata/distance/$latitude/$longitude/$filter');
      var response = await http.get(url, headers: await SecureData.getToken());
      print('ini latitude:$latitude');
      print('ini longitude:$longitude');
      print('ini filter:$filter');
      var wisataData = json.decode(response.body);
      return ResponseWisataDistance.fromJson(wisataData);
    } catch (e) {
      print('Error wisata distance adalah : $e');
      return null;
    }
  }

  static Future<ResponseWisataSearch?> getWisataSearch(
      String search, String filter) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/wisata/cari/$search/$filter');
      var response = await http.get(url, headers: await SecureData.getToken());
      var wisataData = json.decode(response.body);
      return ResponseWisataSearch.fromJson(wisataData);
    } catch (e) {
      print('Error wisata adalah : $e');
      return null;
    }
  }

  static Future<ResponseWisataDetail?> getDetailWisata(String idWisata) async {
    try {
      UserModel user = await SecureData.getUserData();
      String idUser = user.user_id.toString();
      Uri url =
          Uri.parse(ApiUtil.urlBase + 'api/wisata/detail/$idWisata/$idUser');
      var response = await http.get(url, headers: await SecureData.getToken());
      var wisataData = json.decode(response.body);
      print(wisataData);
      return ResponseWisataDetail.fromJson(wisataData);
    } catch (e) {
      print('Error adalah : $e');
      return null;
    }
  }
}
