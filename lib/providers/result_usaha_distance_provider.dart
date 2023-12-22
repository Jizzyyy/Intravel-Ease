import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/controllers/produk_controller.dart';
import 'package:intravel_ease/models/produks/produk_distance_model.dart';
import 'package:intravel_ease/public_providers/public_one_provider.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../public_providers/public_distance_provider.dart';
import '../screens/detail_usaha_screen.dart';

class ResultUsahaDistanceProvider extends ChangeNotifier {
  int? _selected;
  String? filter = 'null';
  get selected => this._selected;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? dataSearch;

  set selected(value) => this._selected = value;

  int? selectedButton = null;

  Future<List<ProdukDistanceModel?>> getWisata(BuildContext context) async {
    final publicDistance =
        Provider.of<PublicDistanceProvider>(context, listen: false);
    final wisata = await ProdukController.getWisataFilterDistance(
        publicDistance.latitude!, publicDistance.longitude!, filter!);
    if (wisata?.status! == 200) {
      return wisata?.data ?? [];
    }
    return [];
  }

  void toDetailWisata(BuildContext context, String idWisata) {
    Provider.of<PublicOneProvider>(context, listen: false)
        .setValues(one: idWisata);
    Navigator.of(context).push(PageTransition(
        child: const DetailUsahaScreen(),
        reverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.topCenter,
        type: PageTransitionType.size));
  }

  String toMoney(int amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  void publicOne(BuildContext context) {
    final publicOne = Provider.of<PublicOneProvider>(context, listen: false);
    dataSearch = publicOne.one.toString();
  }

  void toSearch(BuildContext context) {
    Navigator.pop(context);
  }

  Widget selectedFilter(String text, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w),
      child: ElevatedButton(
        onPressed: () {
          _selected = index;
          notifyListeners();
        },
        child: TextHelper(
          text: '$text',
          fontSize: 13.sp,
          fontFamily: FontFamily.regular,
          fontColor: _selected == index ? AppColors.white : AppColors.black,
        ),
        style: ElevatedButton.styleFrom(
          side: BorderSide(width: 1, color: AppColors.black),
          backgroundColor:
              _selected == index ? AppColors.black : AppColors.white,
        ),
      ),
    );
  }

  void mostReviews(BuildContext context) {
    if (selectedButton == 2) {
      selectedButton = null;
      filter = 'null';
      if (scaffoldKey.currentContext != null) getWisata(context);
    } else {
      selectedButton = 2;
      filter = 'most';
      if (scaffoldKey.currentContext != null) getWisata(context);
    }
    notifyListeners();
  }

  void bestRating(BuildContext context) {
    if (selectedButton == 1) {
      filter = 'null';
      selectedButton = null;
      if (scaffoldKey.currentContext != null) getWisata(context);
    } else {
      selectedButton = 1;
      filter = 'best';
      if (scaffoldKey.currentContext != null) getWisata(context);
    }
    notifyListeners();
  }
}
