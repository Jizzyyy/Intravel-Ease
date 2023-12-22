import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intravel_ease/configs/secure_data.dart';
import 'package:intravel_ease/controllers/rating_wisata_controller.dart';
import 'package:intravel_ease/controllers/wisata_controller.dart';
import 'package:intravel_ease/models/model_shared_preferences/favorite_model.dart';
import 'package:intravel_ease/models/rating_wisata_model.dart';
import 'package:intravel_ease/models/user_model.dart';
import 'package:intravel_ease/models/wisatas/wisata_model_detail.dart';
import 'package:intravel_ease/public_providers/public_distance_provider.dart';
import 'package:intravel_ease/public_providers/public_one_provider.dart';
import 'package:intravel_ease/public_providers/public_two_provider%20.dart';
import 'package:intravel_ease/screens/result_search_distance_screen.dart';
import 'package:intravel_ease/screens/result_usaha_distance_screen.dart';
import 'package:intravel_ease/screens/wisata_review_screen.dart';
import 'package:intravel_ease/widgets/messages_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_sheet.dart';

class DetailPlaceProvider extends ChangeNotifier {
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
  WisataModelDetail? modelDetail;
  bool checkRating = false;
  double myRating = 0;
  ScrollController scrollController = ScrollController();

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
        id: modelDetail!.wisata_id.toString(),
        kategori: '1',
        nama: modelDetail!.wisata_nama.toString(),
        gambar: modelDetail!.image![0].gambar_wisata_gambar!,
        kota: modelDetail!.wisata_kota.toString(),
        provinsi: modelDetail!.wisata_provinsi.toString());
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
      String idWisata = publicOne.one.toString();
      EasyLoading.show();
      final response = await RatingWisataController.addReview(
          userModel.user_id.toString(),
          idWisata,
          ratingComment!,
          commentController.text);
      EasyLoading.dismiss();
      if (response!.status == 201) {
        if (scaffoldKey.currentContext != null) {
          MessagesSnacbar.success(context, 'Ulasa telah dikirim');
          commentController.text = '';
          notifyListeners();
        }
      }
    }
  }

  void showBottomSheet(BuildContext context) {
    Provider.of<PublicTwoProvider>(context, listen: false).setValues(
        one: modelDetail?.wisata_id.toString(),
        two: modelDetail?.wisata_nama.toString());
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const ListBottomSheet();
        });
  }

  toNearestSpot(BuildContext context, String latitude, String longitude) {
    Provider.of<PublicDistanceProvider>(context, listen: false)
        .setValues(latitude: latitude, longitude: longitude);
    Navigator.of(context).push(PageTransition(
        child: const ResultSearchDistanceScreen(),
        reverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.bottomCenter,
        type: PageTransitionType.size));
  }

  toNearestUsaha(BuildContext context, String latitude, String longitude) {
    Provider.of<PublicDistanceProvider>(context, listen: false)
        .setValues(latitude: latitude, longitude: longitude);
    Navigator.of(context).push(PageTransition(
        child: const ResultUsahaDistanceScreen(),
        reverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.bottomCenter,
        type: PageTransitionType.size));
  }

  Future<List<RatingWisataModel>?> getPaginate(BuildContext context) async {
    final publicOne = Provider.of<PublicOneProvider>(context, listen: false);
    String idWisata = publicOne.one.toString();
    final rating = await RatingWisataController.getPaginate(idWisata);
    if (rating?.status == 200) {
      return rating?.data;
    }
    return null;
  }

  Future<WisataModelDetail?> getWisataDetail(BuildContext context) async {
    final publicOne = Provider.of<PublicOneProvider>(context, listen: false);
    String idWisata = publicOne.one.toString();
    final wisata = await WisataController.getDetailWisata(idWisata);
    if (wisata?.status == 200) {
      if (wisata?.review != null) {
        commentController.text = wisata!.review!.ratingws_komentar!;
        checkRating = true;
        ratingComment = wisata.review!.ratingws_rating!;
        myRating = wisata.review!.ratingws_rating!;
      }
      modelDetail = wisata?.data;
      return wisata?.data;
    }
    return null;
  }

  void toAllReview(BuildContext context) {
    Navigator.of(context).push(PageTransition(
        child: const WisataReviewScreen(),
        reverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.bottomCenter,
        type: PageTransitionType.size));
  }
}
