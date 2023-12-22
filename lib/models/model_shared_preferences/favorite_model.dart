import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteModel {
  String id;
  String kategori;
  String nama;
  String gambar;
  String kota;
  String provinsi;

  FavoriteModel({
    required this.id,
    required this.kategori,
    required this.nama,
    required this.gambar,
    required this.kota,
    required this.provinsi,
  });

  static Future<void> saveFavorite(FavoriteModel favoriteModel) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favorite') ?? [];
    final favoriteData = {
      'id': favoriteModel.id,
      'kategori': favoriteModel.kategori,
      'nama': favoriteModel.nama,
      'gambar': favoriteModel.gambar,
      'kota': favoriteModel.kota,
      'provinsi': favoriteModel.provinsi,
    };
    final favoriteDataJson = json.encode(favoriteData); // Ubah ke format JSON
    favoriteList.add(favoriteDataJson);
    await prefs.setStringList('favorite', favoriteList);
  }

  static Future<List<FavoriteModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favorite') ?? [];
    final List<FavoriteModel> favorites = favoriteList.map((item) {
      final Map<String, dynamic> favoriteData = json.decode(item);
      return FavoriteModel(
        id: favoriteData['id'],
        kategori: favoriteData['kategori'],
        nama: favoriteData['nama'],
        gambar: favoriteData['gambar'],
        kota: favoriteData['kota'],
        provinsi: favoriteData['provinsi'],
      );
    }).toList();
    print('length : ${favorites.length}');
    return favorites;
  }

  static Future<void> removeFavoriteAtIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favorite') ?? [];
    if (index >= 0 && index < favoriteList.length) {
      favoriteList.removeAt(index);
      await prefs.setStringList('favorite', favoriteList);
    }
  }
}
