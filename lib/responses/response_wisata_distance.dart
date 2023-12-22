import '../models/wisatas/wisata_model_distance.dart';

class ResponseWisataDistance {
  final int? status;
  final String? title;
  final String? message;
  final List<WisataModelDistance>? data;

  ResponseWisataDistance({
    this.status,
    this.title,
    this.message,
    this.data,
  });

  factory ResponseWisataDistance.fromJson(Map<String, dynamic> json) {
    List<WisataModelDistance> fillData = [];
    fillData = json['data']
        .map<WisataModelDistance>((json) => WisataModelDistance.fromJson(json))
        .toList();
    return ResponseWisataDistance(
      status: json['status'],
      title: json['title'],
      message: json['message'],
      data: fillData,
    );
  }
}
