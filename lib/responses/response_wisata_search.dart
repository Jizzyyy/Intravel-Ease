import 'package:intravel_ease/models/wisatas/wisata_model_search.dart';

class ResponseWisataSearch {
  final int? status;
  final String? title;
  final String? message;
  final List<WisataModelSearch>? data;

  ResponseWisataSearch({
    this.status,
    this.title,
    this.message,
    this.data,
  });

  factory ResponseWisataSearch.fromJson(Map<String, dynamic> json) {
    List<WisataModelSearch> fillData = [];
    fillData = json['data']
        .map<WisataModelSearch>((json) => WisataModelSearch.fromJson(json))
        .toList();
    return ResponseWisataSearch(
      status: json['status'],
      title: json['title'],
      message: json['message'],
      data: fillData,
    );
  }
}
