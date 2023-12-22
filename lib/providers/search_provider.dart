import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/public_providers/public_one_provider.dart';
import 'package:intravel_ease/screens/result_search_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../configs/app_color.dart';
import '../configs/font_family.dart';
import '../widgets/text_helper.dart';

class SearchProvider extends ChangeNotifier {
  int? _selected;
  get selected => this._selected;
  final TextEditingController searchController = TextEditingController();

  set selected(value) => this._selected = value;

  void buttonSearch(BuildContext context, String value) {
    if (value.trim().isNotEmpty) {
      saveData(value);
      notifyListeners();
      Provider.of<PublicOneProvider>(context, listen: false)
          .setValues(one: value);
      Navigator.of(context).push(PageTransition(
          child: const ResultSearchScreen(),
          reverseDuration: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.rightToLeftWithFade));
    }
  }

  void allTours(BuildContext context, String value) {
    Provider.of<PublicOneProvider>(context, listen: false)
        .setValues(one: value);
    Navigator.of(context).push(PageTransition(
        child: const ResultSearchScreen(),
        reverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 500),
        type: PageTransitionType.rightToLeftWithFade));
  }

  void saveData(String newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList('search_data');
    if (newData.trim() == '' || newData.trim().isEmpty) {
      newData = 'Lihat Semua Wisata';
    }
    if (data == null) {
      data ??= [];
      data.insert(0, 'Lihat Semua Wisata');
      data.insert(0, newData);
    } else if (data.length < 6) {
      data.insert(0, newData);
      data.removeAt(data.length - 1);
      data.insert(data.length, 'Lihat Semua Wisata');
    } else {
      data.removeAt(data.length - 1);
      data.removeAt(data.length - 1);
      data.insert(0, newData);
      data.insert(data.length, 'Lihat Semua Wisata');
    }
    await prefs.setStringList('search_data', data);
  }

  Future<List<String?>> historySearch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? history = prefs.getStringList('search_data');
    return history ?? [];
  }

  Widget selectedFilter(String text, int index) {
    return Container(
      height: 200.h,
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

  // changeStatusColor(Color color) async {
  //   try {
  //     await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
  //     if (useWhiteForeground(color)) {
  //       FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  //       FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
  //       // _useWhiteStatusBarForeground = true;
  //       // _useWhiteNavigationBarForeground = true;
  //     } else {
  //       FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  //       FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
  //       // _useWhiteStatusBarForeground = false;
  //       // _useWhiteNavigationBarForeground = false;
  //     }
  //   } on PlatformException catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // changeNavigationColor(Color color) async {
  //   try {
  //     await FlutterStatusbarcolor.setNavigationBarColor(color, animate: true);
  //   } on PlatformException catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}
