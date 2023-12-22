import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AgendaModel {
  String? id;
  int? inc;
  String? kategori;
  String? namaWisata;
  String? deskripsi;
  String? tanggal;
  String? jamMulai;
  String? jamSelesai;
  String? warna;

  AgendaModel({
    required this.id,
    required this.kategori,
    required this.namaWisata,
    required this.deskripsi,
    required this.tanggal,
    required this.jamMulai,
    required this.jamSelesai,
    required this.warna,
    this.inc,
  });

  static Future<void> saveItinerary(AgendaModel agendaModel) async {
    final pref = await SharedPreferences.getInstance();
    final itineraryList = pref.getStringList('itinerary') ?? [];
    List<AgendaModel> agenda = await getItinerary();
    int increement = 0;
    if (agenda.isNotEmpty) {
      increement = agenda.last.inc! + 1;
    }
    final itineraryData = {
      'id': agendaModel.id,
      'inc': increement,
      'kategori': agendaModel.kategori,
      'namaWisata': agendaModel.namaWisata,
      'deskripsi': agendaModel.deskripsi,
      'tanggal': agendaModel.tanggal,
      'jamMulai': agendaModel.jamMulai,
      'jamSelesai': agendaModel.jamSelesai,
      'warna':
          agendaModel.warna, // Menyimpan warna sebagai string dalam format hex
    };
    final itineraryDataJson = json.encode(itineraryData);
    itineraryList.add(itineraryDataJson);
    await pref.setStringList('itinerary', itineraryList);
  }

  static Future<List<AgendaModel>> getItinerary() async {
    final prefs = await SharedPreferences.getInstance();
    final itineraryList = prefs.getStringList('itinerary') ?? [];
    final List<AgendaModel> itinerary = itineraryList.map((item) {
      final Map<String, dynamic> itineraryData = json.decode(item);
      return AgendaModel(
        id: itineraryData['id'],
        inc: itineraryData['inc'],
        kategori: itineraryData['kategori'],
        namaWisata: itineraryData['namaWisata'],
        deskripsi: itineraryData['deskripsi'],
        tanggal: itineraryData['tanggal'],
        jamMulai: itineraryData['jamMulai'],
        jamSelesai: itineraryData['jamSelesai'],
        warna: itineraryData['warna'], // Mengambil warna dari String hex
      );
    }).toList();
    print('length : ${itinerary.length}');
    return itinerary;
  }

  // static Future<void> updateItinerary(
  //     int index, AgendaModel updatedAgendaModel) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final itineraryListJson = prefs.getStringList('itinerary') ?? [];

  //   if (index >= 0 && index < itineraryListJson.length) {
  //     // Convert the JSON data to a List of Map<String, dynamic>
  //     List<Map<String, dynamic>> itineraryList = [];
  //     itineraryListJson.forEach((jsonData) {
  //       Map<String, dynamic> agendaData = json.decode(jsonData);
  //       itineraryList.add(agendaData);
  //     });

  //     // Update the data at the given index
  //     if (index < itineraryList.length) {
  //       final updatedItineraryData = {
  //         'id': updatedAgendaModel.id,
  //         'kategori': updatedAgendaModel.kategori,
  //         'namaWisata': updatedAgendaModel.namaWisata,
  //         'deskripsi': updatedAgendaModel.deskripsi,
  //         'tanggal': updatedAgendaModel.tanggal,
  //         'jamMulai': updatedAgendaModel.jamMulai,
  //         'jamSelesai': updatedAgendaModel.jamSelesai,
  //         'warna': updatedAgendaModel.warna,
  //       };

  //       itineraryList[index] = updatedItineraryData;

  //       // Convert the List of Map to a List of JSON strings
  //       List<String> updatedItineraryListJson = itineraryList.map((agendaData) {
  //         return json.encode(agendaData);
  //       }).toList();

  //       // Save the updated list back to SharedPreferences
  //       await prefs.setStringList('itinerary', updatedItineraryListJson);
  //     }
  //   }
  // }

  static Future<void> resetItineraryData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('itinerary');
    print('Data itinerary berhasil direset.');
  }

  // static Future<void> updateItinerary(
  //     int index, AgendaModel updatedAgendaModel) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final itineraryList = prefs.getStringList('itinerary') ?? [];

  //   if (index >= 0 && index < itineraryList.length) {
  //     // Remove the existing data at the given index
  //     itineraryList.removeAt(index);

  //     // Convert the updated AgendaModel to a JSON Map
  //     final updatedItineraryData = {
  //       'id': updatedAgendaModel.id,
  //       'kategori': updatedAgendaModel.kategori,
  //       'namaWisata': updatedAgendaModel.namaWisata,
  //       'deskripsi': updatedAgendaModel.deskripsi,
  //       'tanggal': updatedAgendaModel.tanggal,
  //       'jamMulai': updatedAgendaModel.jamMulai,
  //       'jamSelesai': updatedAgendaModel.jamSelesai,
  //       'warna': updatedAgendaModel.warna,
  //     };
  //     final updatedItineraryDataJson = json.encode(updatedItineraryData);

  //     // Insert the updated data back at the same index
  //     itineraryList.insert(index, updatedItineraryDataJson);

  //     // Save the updated list back to SharedPreferences
  //     await prefs.setStringList('itinerary', itineraryList);
  //   }
  // }

  static Future<List<AgendaModel>> getItineraryList() async {
    final prefs = await SharedPreferences.getInstance();
    final itineraryList = prefs.getStringList('itinerary') ?? [];

    List<AgendaModel> agendaList = [];

    for (int i = 0; i < itineraryList.length; i++) {
      final itineraryData = json.decode(itineraryList[i]);
      AgendaModel agendaModel = AgendaModel(
        id: itineraryData['id'],
        kategori: itineraryData['kategori'],
        namaWisata: itineraryData['namaWisata'],
        deskripsi: itineraryData['deskripsi'],
        tanggal: itineraryData['tanggal'],
        jamMulai: itineraryData['jamMulai'],
        jamSelesai: itineraryData['jamSelesai'],
        warna: itineraryData['warna'],
      );
      agendaList.add(agendaModel);
    }

    return agendaList;
  }

  static Future<void> removeItineraryAtIndex(int targetInc) async {
    final prefs = await SharedPreferences.getInstance();
    final itineraryList = prefs.getStringList('itinerary') ?? [];

    int targetIndex = -1;
    for (int i = 0; i < itineraryList.length; i++) {
      final Map<String, dynamic> itineraryData = json.decode(itineraryList[i]);
      if (itineraryData['inc'] == targetInc) {
        targetIndex = i;
        break;
      }
    }

    if (targetIndex != -1) {
      // Jika index ditemukan, hapus objek tersebut dari list dan simpan kembali
      itineraryList.removeAt(targetIndex);
      await prefs.setStringList('itinerary', itineraryList);
      print('Data dengan inc $targetInc berhasil dihapus.');
    } else {
      print('Tidak ditemukan data dengan inc $targetInc.');
    }
  }
}
