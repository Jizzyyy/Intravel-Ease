import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:intravel_ease/models/model_shared_preferences/agenda_model.dart';
import 'package:intravel_ease/public_providers/public_agenda_provider.dart';
import 'package:intravel_ease/widgets/dialog_material.dart';
import 'package:intravel_ease/widgets/messages_snackbar.dart';
import 'package:provider/provider.dart';

import '../public_providers/public_two_provider .dart';
import '../screens/edit_list_itinerary.dart';

class DetailScheduleProvider extends ChangeNotifier {
  DateTime selectedDatePicker = DateTime.now();
  String? date = DateFormat.yMMMMd("id_ID").format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  List<AgendaModel> filteredAgendaList = [];

  void buttonDelete(BuildContext context, int inc) {
    DialogMaterial.yesNo(context, () async {
      await EasyLoading.show(
        status: 'memuat...',
        maskType: EasyLoadingMaskType.clear,
      );
      await Future.delayed(const Duration(seconds: 1));
      EasyLoading.dismiss();
      removeItinerary(context, inc);
      Navigator.pop(context);
      listData();
      notifyListeners();
    });
  }

  void listData() async {
    List<AgendaModel> allAgenda = await AgendaModel.getItinerary();

    List<AgendaModel> filteredAgendaList = allAgenda.where((agenda) {
      DateTime agendaDateTime = _convertToDate(agenda.tanggal!);
      return agendaDateTime.year == selectedDate.year &&
          agendaDateTime.month == selectedDate.month &&
          agendaDateTime.day == selectedDate.day;
    }).toList();
    this.filteredAgendaList = filteredAgendaList;
    notifyListeners();
  }

  List<Color> colors = [Colors.green, Colors.red, Colors.blue];

  DateTime _convertToDate(String dateStr) {
    List<String> dateParts = dateStr.split('/');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);
    return DateTime(year, month, day);
  }

  void removeItinerary(BuildContext context, int index) async {
    await AgendaModel.removeItineraryAtIndex(index);
    MessagesSnacbar.success(context, 'Berhasil Dihapus');
    notifyListeners();
  }

  void resetItinerary(BuildContext context) async {
    await AgendaModel.resetItineraryData();
    MessagesSnacbar.success(context, 'Jadwal Telah Diatur Ulang');
    listData();
    notifyListeners();
  }

  void toUpdateScreen(
      BuildContext context,
      String id,
      int inc,
      String kategori,
      String namaWisata,
      String deskripsi,
      String tanggal,
      String jamMulai,
      String jamSelesai,
      String warna) {
    final publicAgenda =
        Provider.of<PublicAgendaProvider>(context, listen: false).setValues(
      id,
      inc,
      kategori,
      namaWisata,
      deskripsi,
      tanggal,
      jamMulai,
      jamSelesai,
      warna,
    );
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const EditItinerary()));
  }

  // AgendaModel? modelAgenda;
  // void addListItinerary(BuildContext context) async {
  //   final test = Provider.of<PublicTwoProvider>(context, listen: false);
  //   AgendaModel agendaModel = AgendaModel(
  //     // id:modelAgenda?.id.toString(),
  //     id: test.one,
  //     kategori: '1',
  //     namaWisata: test.two,
  //     deskripsi: modelAgenda!.tanggal,
  //     tanggal: DateFormat.yMd("id_ID").format(selectedDate),
  //     jamMulai: modelAgenda!.jamMulai,
  //     jamSelesai: modelAgenda!.jamSelesai,
  //     warna: modelAgenda!.warna,
  //   );
  //   AgendaModel.saveItinerary(agendaModel);
  //   // if (scaffoldKey.currentContext != null) {
  //   //   MessagesSnacbar.success(context, 'Berhasil Menambahkan List Andaaa');
  //   // }
  // }
}
