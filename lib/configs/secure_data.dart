import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intravel_ease/models/user_model.dart';

class SecureData {
  static Future<Map<String, String>> getToken() async {
    final storage = new FlutterSecureStorage();
    String? jsonString = await storage.read(key: 'token');
    return {
      'Authorization': 'Bearer $jsonString',
    };
  }

  static Future<UserModel> getUserData() async {
    final storage = new FlutterSecureStorage();
    String? jsonString = await storage.read(key: 'user_data');
    UserModel objectData = UserModel.fromJson(json.decode(jsonString!));
    return objectData;
  }
}
