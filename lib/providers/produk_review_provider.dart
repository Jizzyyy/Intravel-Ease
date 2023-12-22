import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/controllers/rating_produk_controller.dart';
import 'package:intravel_ease/models/produks/rating_produk_model.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';
import '../public_providers/public_one_provider.dart';

class ProdukReviewProvider extends ChangeNotifier {
  int selectedButtonIndex = 0;

  String idWisata(BuildContext context) {
    return Provider.of<PublicOneProvider>(context, listen: false)
        .one
        .toString();
  }

  Future<List<RatingProdukModel>?> getFilter(BuildContext context) async {
    final publicOne = Provider.of<PublicOneProvider>(context, listen: false);
    String idWisata = publicOne.one.toString();
    final rating = await RatingProdukController.filterReview(
        idWisata, selectedButtonIndex.toString());
    if (rating?.status == 200) {
      return rating?.data;
    }
    return null;
  }

  Widget buttonRadio(int index, String text, BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedButtonIndex = index;
          notifyListeners();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: selectedButtonIndex == index
                ? AppColors.black
                : AppColors.white,
            border: Border.all(color: AppColors.black, width: 2),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                text != 'Semua'
                    ? Padding(
                        padding: EdgeInsets.only(right: 3.w),
                        child: Icon(
                          Icons.star,
                          color: selectedButtonIndex == index
                              ? AppColors.white
                              : AppColors.black,
                        ),
                      )
                    : Wrap(),
                TextHelper(
                  text: text,
                  fontSize: 15.sp,
                  fontColor: selectedButtonIndex == index
                      ? AppColors.white
                      : AppColors.black,
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
