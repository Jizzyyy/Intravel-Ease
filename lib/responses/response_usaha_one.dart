import 'package:intravel_ease/models/usaha_model.dart';

class ResponseUsahaOne {
  final int? status;
  final String? title;
  final String? message;
  final UsahaModel? data;

  ResponseUsahaOne({
    this.status,
    this.title,
    this.message,
    this.data,
  });

  factory ResponseUsahaOne.fromJson(Map<String, dynamic> json) {
    var dataku = null;
    if (json['data'] != null) {
      dataku = UsahaModel.fromJson(json['data']);
    }
    return ResponseUsahaOne(
      status: json['status'],
      title: json['title'],
      message: json['message'],
      data: dataku,
    );
  }
}
