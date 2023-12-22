import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intravel_ease/configs/secure_data.dart';
import 'package:intravel_ease/controllers/produk_controller.dart';
import 'package:intravel_ease/controllers/rating_produk_controller.dart';
import 'package:intravel_ease/models/model_shared_preferences/favorite_model.dart';
import 'package:intravel_ease/models/produks/produk_detail_model.dart';
import 'package:intravel_ease/models/produks/rating_produk_model.dart';
import 'package:intravel_ease/models/usaha_model.dart';
import 'package:intravel_ease/models/user_model.dart';
import 'package:intravel_ease/public_providers/public_one_provider.dart';
import 'package:intravel_ease/public_providers/public_two_provider%20.dart';
import 'package:intravel_ease/screens/produk_review_screen.dart';
import 'package:intravel_ease/widgets/bottom_sheet2.dart';
import 'package:intravel_ease/widgets/messages_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/detail_schedule_screen.dart';

class DetailUsahaProvider extends ChangeNotifier {
  final String startTime = DateFormat("hh:mm").format(DateTime.now());
  final String endTime = "09:30";
  int selectedColor = 0;
  DateTime selectedDate = DateTime.now();
  final TextEditingController descController = TextEditingController();
  final TextEditingController tglController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  GoogleMapController? mapController;
  var formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double? ratingComment;
  ProdukDetailModel? modelDetail;
  UsahaModel? modelUsaha;

  getDateFromUser(BuildContext context) async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));

    if (_pickerDate != null) {
      selectedDate = _pickerDate;
      notifyListeners();
    } else {
      ("Error!");
    }
  }

  void addFavorite(BuildContext context) async {
    FavoriteModel favoriteModel = FavoriteModel(
        id: modelDetail!.produk_id.toString(),
        kategori: '2',
        nama: modelDetail!.produk_nama.toString(),
        gambar: modelDetail!.produk_gambar!,
        kota: modelDetail!.usaha!.usaha_kota.toString(),
        provinsi: modelDetail!.usaha!.usaha_provinsi.toString());
    FavoriteModel.saveFavorite(favoriteModel);
    if (scaffoldKey.currentContext != null)
      MessagesSnacbar.success(context, 'Ditambahkan ke favorit');
  }

  void addComment(BuildContext context) async {
    if (commentController.text.trim().toString().isEmpty) {
      if (scaffoldKey.currentContext != null)
        MessagesSnacbar.warning(context, 'Masukkan Komentar');
    } else if (ratingComment == null) {
      if (scaffoldKey.currentContext != null)
        MessagesSnacbar.warning(context, 'Masukkan Rating');
    } else {
      UserModel userModel = await SecureData.getUserData();
      final publicOne = Provider.of<PublicOneProvider>(context, listen: false);
      String idProduk = publicOne.one.toString();
      EasyLoading.show();
      final response = await RatingProdukController.addReview(
          userModel.user_id.toString(),
          idProduk,
          ratingComment!,
          commentController.text);
      EasyLoading.dismiss();
      if (response!.status == 201) {
        if (scaffoldKey.currentContext != null) {
          MessagesSnacbar.success(context, 'Ulasan Berhasil Ditambahkan');
          commentController.text = '';
          notifyListeners();
        }
      }
    }
  }

  String toMoney(int amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  Future<List<RatingProdukModel>?> getPaginate(BuildContext context) async {
    final publicOne = Provider.of<PublicOneProvider>(context, listen: false);
    String idProduk = publicOne.one.toString();
    final rating = await RatingProdukController.getPaginate(idProduk);
    if (rating?.status == 200) {
      return rating?.data;
    }
    return null;
  }

  Future<ProdukDetailModel?> getProdukDetail(BuildContext context) async {
    final publicOne = Provider.of<PublicOneProvider>(context, listen: false);
    String idWisata = publicOne.one.toString();
    final wisata = await ProdukController.getDetailProduk(idWisata);
    if (wisata?.status == 200) {
      modelDetail = wisata?.data;
      print('ini model : ${modelDetail!.produk_nama}');
      print('ini model ini: ${wisata?.data!.produk_nama}');
      return wisata?.data;
    }
    return null;
  }

  void showBottomSheet(BuildContext context) {
    Provider.of<PublicTwoProvider>(context, listen: false).setValues(
        one: modelDetail!.produk_id.toString(),
        two: modelDetail!.produk_nama.toString());
    print(modelDetail!.produk_nama.toString() + 'ini model deatil');
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const ListBottomSheetUsaha();
        });
  }
  // validate task

  void toAllReview(BuildContext context) {
    Navigator.of(context).push(PageTransition(
        child: const ProdukReviewScreen(),
        reverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.bottomCenter,
        type: PageTransitionType.size));
  }

  validateDate(BuildContext context) {
    if (descController.text.isNotEmpty ||
        tglController.text.isNotEmpty ||
        startTimeController.text.isNotEmpty ||
        endTimeController.text.isNotEmpty) {
      sendData();
      Navigator.of(context).push(PageTransition(
          child: const DetailSchedule(),
          reverseDuration: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 500),
          alignment: Alignment.bottomCenter,
          type: PageTransitionType.size));
    } else if (descController.text.isEmpty ||
        tglController.text.isEmpty ||
        startTimeController.text.isEmpty ||
        endTimeController.text.isEmpty) {
      AnimatedSnackBar.material(
        'Isi Semua Field !',
        type: AnimatedSnackBarType.warning,
        duration: const Duration(seconds: 4),
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
    }
  }
  //

  // shared send data
  void sendData() async {
    String _deskripsi = descController.toString();
    String _tanggal = tglController.toString();
    String starttime = startTimeController.toString();
    String endtime = endTimeController.toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    String currentDate = '${now.year}-${now.month}-${now.day}';
    String key = '$currentDate-${selectedColor.toString()}';

    await prefs.setString(key, _deskripsi);
    await prefs.setString(key, _tanggal);
    await prefs.setString(key, starttime);
    await prefs.setString(key, endtime);
  }
}
