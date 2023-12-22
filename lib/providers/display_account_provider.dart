import 'package:flutter/material.dart';
import 'package:intravel_ease/configs/secure_data.dart';
import 'package:intravel_ease/models/user_model.dart';

class DisplayAccountProvider extends ChangeNotifier {
  Future<UserModel> getUser() async {
    UserModel model = await SecureData.getUserData();
    return model;
  }
}
