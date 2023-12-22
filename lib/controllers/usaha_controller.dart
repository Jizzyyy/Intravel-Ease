import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intravel_ease/configs/api_util.dart';
import 'package:intravel_ease/configs/secure_data.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../responses/response_usaha_one.dart';

class UsahaController {
  static Future<ResponseUsahaOne?> addBussiness(
    String kategoriId,
    String nama,
    String produk,
    String kontak,
    String deskripsi,
    String latitude,
    String longitude,
    String alamat,
    String kota,
    String provinsi,
    File gambar,
  ) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/usaha/buat');
      UserModel userData = await SecureData.getUserData();
      var request = http.MultipartRequest('POST', url);
      request.fields['usaha_idpengguna'] = userData.user_id.toString();
      request.fields['usaha_idkategori'] = kategoriId;
      request.fields['usaha_nama'] = nama;
      request.fields['usaha_produk'] = produk;
      request.fields['usaha_kontak'] = kontak;
      request.fields['usaha_deskripsi'] = deskripsi;
      request.fields['usaha_latitude'] = latitude;
      request.fields['usaha_longitude'] = longitude;
      request.fields['usaha_alamat'] = alamat;
      request.fields['usaha_kota'] = kota;
      request.fields['usaha_provinsi'] = provinsi;
      request.files
          .add(await http.MultipartFile.fromPath('usaha_gambar', gambar.path));
      final storage = new FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      request.headers['Authorization'] = 'Bearer $token';
      var response = await request.send();
      // if (response.statusCode == 201) {
      var responseData = await response.stream.toBytes();
      var usahaData = json.decode(utf8.decode(responseData));
      return ResponseUsahaOne.fromJson(usahaData);
      // } else {
      //   return null;
      // }
    } catch (e) {
      print('error controller : $e');
      return null;
    }
  }

  static Future<ResponseUsahaOne?> updateUsaha(
    String kategoriId,
    String nama,
    String produk,
    String kontak,
    String deskripsi,
    String latitude,
    String longitude,
    String alamat,
    String kota,
    String provinsi,
    File? gambar,
    String idUsaha,
  ) async {
    try {
      // print('kategori $kategoriId iniku');
      // print('nama $nama iniku');
      // print('produk $produk iniku');
      // print('kontak $kontak iniku');
      // print('deskripsi $deskripsi iniku');
      // print('latitude $latitude iniku');
      // print('longitude $longitude iniku');
      // print('alamat $alamat iniku');
      // print('kota $kota iniku');
      // print('provinsi $provinsi iniku');
      // print('idusaha $idUsaha iniku');
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/usaha/update');
      UserModel userData = await SecureData.getUserData();
      var request = http.MultipartRequest('POST', url);
      request.fields['usaha_idpengguna'] = userData.user_id.toString();
      request.fields['usaha_id'] = idUsaha;
      request.fields['usaha_idkategori'] = kategoriId;
      request.fields['usaha_nama'] = nama;
      request.fields['usaha_produk'] = produk;
      request.fields['usaha_kontak'] = kontak;
      request.fields['usaha_deskripsi'] = deskripsi;
      request.fields['usaha_latitude'] = latitude;
      request.fields['usaha_longitude'] = longitude;
      request.fields['usaha_alamat'] = alamat;
      request.fields['usaha_kota'] = kota;
      request.fields['usaha_provinsi'] = provinsi;
      if (gambar != null) {
        request.files.add(
            await http.MultipartFile.fromPath('usaha_gambar', gambar.path));
      }
      final storage = new FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      request.headers['Authorization'] = 'Bearer $token';
      var response = await request.send();
      // if (response.statusCode == 201) {
      var responseData = await response.stream.toBytes();
      var usahaData = json.decode(utf8.decode(responseData));
      return ResponseUsahaOne.fromJson(usahaData);
      // } else {
      //   return null;
      // }
    } catch (e) {
      print('error controller : $e');
      return null;
    }
  }

  static Future<ResponseUsahaOne?> checkUsaha() async {
    try {
      UserModel userModel = await SecureData.getUserData();
      String user_id = userModel.user_id.toString();
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/usaha/check/$user_id');
      var response = await http.get(url, headers: await SecureData.getToken());
      var wisataData = json.decode(response.body);
      return ResponseUsahaOne.fromJson(wisataData);
    } catch (e) {
      print('Error adalah : $e');
      return null;
    }
  }
}
