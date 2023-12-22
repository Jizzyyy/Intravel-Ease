import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intravel_ease/configs/api_util.dart';
import 'package:intravel_ease/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController {
  final int? status;
  final String? title;
  final String? message;
  final UserModel? data;
  final String? token;

  UserController(
      {this.status, this.title, this.message, this.data, this.token});

  factory UserController.fromJson(Map<String, dynamic> json) {
    var userData = null;
    String? userToken = null;
    if (json['data'] != null) {
      userData = UserModel.fromJson(json['data']);
    }
    if (json['token'] != null) {
      userToken = json['token'];
    }

    return UserController(
        status: json['status'],
        title: json['title'],
        message: json['message'],
        data: userData,
        token: userToken);
  }

  static Future<UserController?> loginUser(
      BuildContext context, String email, String password) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/login');
      var response = await http
          .post(url, body: {'user_email': email, 'password': password});
      return UserController.fromJson(json.decode(response.body));
    } catch (e) {
      AnimatedSnackBar.rectangle('Terjadi Kesalahan',
              'Periksa kembali jaringan internet anda atau tunggu beberapa saat.',
              type: AnimatedSnackBarType.error, brightness: Brightness.light)
          .show(context);
      print('error adalah : ${e.toString()}');
      return null;
      // throw Exception('Error : ${e.toString()}');
    }
  }

  static Future<UserController?> updateUser(
    String email,
    String nama,
    String telepon,
    String kelamin,
    String alamat,
    String password,
    File? gambar,
  ) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/user/update');
      var request = http.MultipartRequest('POST', url);
      request.fields['user_email'] = email;
      request.fields['user_nama'] = nama;
      request.fields['user_telepon'] = telepon;
      request.fields['user_gender'] = kelamin;
      request.fields['user_alamat'] = alamat;
      request.fields['password'] = password;
      if (gambar != null) {
        request.files
            .add(await http.MultipartFile.fromPath('user_foto', gambar.path));
      }
      final storage = new FlutterSecureStorage();
      String? token = await storage.read(key: 'token');
      request.headers['Authorization'] = 'Bearer $token';
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var usahaData = json.decode(utf8.decode(responseData));
      return UserController.fromJson(usahaData);
    } catch (e) {
      print('error controller update user : $e');
      return null;
    }
  }

  static Future<UserController?> registerUser(
      BuildContext context, nama, String email, String password) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/register');
      var response = await http.post(url,
          body: {'user_nama': nama, 'user_email': email, 'password': password});
      var userData = json.decode(response.body);
      return UserController.fromJson(userData);
    } catch (e) {
      AnimatedSnackBar.rectangle('Terjadi Kesalahan',
              'Periksa kembali jaringan internet anda atau tunggu beberapa saat.',
              type: AnimatedSnackBarType.error, brightness: Brightness.light)
          .show(context);
      return null;
      // throw Exception('Error : ');
    }
  }

  static Future<UserController?> changePassword(
      BuildContext context, email, String sandiLama, String sandiBaru) async {
    try {
      Uri url = Uri.parse(ApiUtil.urlBase + 'api/user/password/ubah');
      var response = await http.post(url, body: {
        'user_email': email,
        'password': sandiLama,
        'user_sandi': sandiBaru
      });
      var userData = json.decode(response.body);
      return UserController.fromJson(userData);
    } catch (e) {
      // AnimatedSnackBar.rectangle('Terjadi Kesalahan',
      //         'Periksa kembali jaringan internet anda atau tunggu beberapa saat.',
      //         type: AnimatedSnackBarType.error, brightness: Brightness.light)
      //     .show(context);
      return null;
      // throw Exception('Error : ');
    }
  }
}
