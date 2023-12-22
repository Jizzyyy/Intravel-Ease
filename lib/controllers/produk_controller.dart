import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intravel_ease/responses/response_detail_produk.dart';
import 'package:intravel_ease/responses/response_distance_produk.dart';
import '../configs/api_util.dart';
import '../configs/secure_data.dart';
import 'package:http/http.dart' as http;

import '../responses/response_produk.dart';

class ProdukController {
  static Future<ResponseProduk?> destroyProduct(String idUsaha) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/produk/destroy');
      var request = http.MultipartRequest('POST', url);
      request.fields['produk_id'] = idUsaha;
      final storage = new FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      request.headers['Authorization'] = 'Bearer $token';
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var usahaData = json.decode(utf8.decode(responseData));
      return ResponseProduk.fromJson(usahaData);
    } catch (e) {
      print('error controller : $e');
      return null;
    }
  }

  static Future<ResponseProduk?> addProduct(
    String idUsaha,
    String nama,
    String harga,
    File gambar,
  ) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/produk/add');
      var request = http.MultipartRequest('POST', url);
      request.fields['produk_idusaha'] = idUsaha;
      request.fields['produk_nama'] = nama;
      request.fields['produk_harga'] = harga;
      request.files
          .add(await http.MultipartFile.fromPath('produk_gambar', gambar.path));
      final storage = new FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      request.headers['Authorization'] = 'Bearer $token';
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var usahaData = json.decode(utf8.decode(responseData));
      return ResponseProduk.fromJson(usahaData);
    } catch (e) {
      print('error controller : $e');
      return null;
    }
  }

  static Future<ResponseProduk?> updateProduct(
    String idProduk,
    String nama,
    String harga,
    File? gambar,
  ) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/produk/update');
      var request = http.MultipartRequest('POST', url);
      request.fields['produk_id'] = idProduk;
      request.fields['produk_nama'] = nama;
      request.fields['produk_harga'] = harga;
      if (gambar != null) {
        request.files.add(
            await http.MultipartFile.fromPath('produk_gambar', gambar.path));
      }
      final storage = new FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      request.headers['Authorization'] = 'Bearer $token';
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var usahaData = json.decode(utf8.decode(responseData));
      return ResponseProduk.fromJson(usahaData);
    } catch (e) {
      print('error controller : $e');
      return null;
    }
  }

  static Future<ResponseProduk?> getProduk(String idUsaha) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/produk/get/$idUsaha');
      var response = await http.get(url, headers: await SecureData.getToken());
      var wisataData = json.decode(response.body);
      return ResponseProduk.fromJson(wisataData);
    } catch (e) {
      print('Error adalah : $e');
      return null;
    }
  }

  static Future<ResponseDistanceProduk?> getProdukDistance(
      String latitude, String longitude) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/produk/distance');
      var response = await http.post(
        url,
        body: {
          'latitude': latitude,
          'longitude': longitude,
        },
        headers: await SecureData.getToken(),
      );
      var wisataData = json.decode(response.body);
      return ResponseDistanceProduk.fromJson(wisataData);
    } catch (e) {
      print('Error produk distance adalah : $e');
      return null;
    }
  }

  static Future<ResponseDistanceProduk?> getWisataFilterDistance(
      String latitude, String longitude, String filter) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase +
          'api/produk/filter/distance/$latitude/$longitude/$filter');
      var response = await http.get(url, headers: await SecureData.getToken());
      print('ini latitude:$latitude');
      print('ini longitude:$longitude');
      print('ini filter:$filter');
      var wisataData = json.decode(response.body);
      return ResponseDistanceProduk.fromJson(wisataData);
    } catch (e) {
      print('Error wisata distance adalah : $e');
      return null;
    }
  }

  static Future<ResponseDetailProduk?> getDetailProduk(String idUsaha) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/produk/detail/$idUsaha');
      var response = await http.get(url, headers: await SecureData.getToken());
      var wisataData = json.decode(response.body);
      // print(response.body);
      return ResponseDetailProduk.fromJson(wisataData);
    } catch (e) {
      print('Error wisata distance adalah : $e');
      return null;
    }
  }
}
