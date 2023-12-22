// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/widgets/text_helper.dart';

import '../configs/app_color.dart';

class BoxSearchDistance extends StatelessWidget {
  BoxSearchDistance({
    required this.image,
    required this.topText,
    required this.midleText,
    required this.distance,
    this.rating,
    this.onClick,
    Key? key,
  }) : super(key: key);

  String image;
  String topText;
  String midleText;
  double? rating;
  String distance;
  VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    final bool widthOrHeight =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    return Container(
      // width: widthOrHeight ? 175.w / 3 : 175.h,
      // margin: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.h),
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          shadowColor: Colors.grey.withOpacity(0.5),
          elevation: 4,
          padding: EdgeInsets.symmetric(horizontal: 6.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(7.r),
              child: Stack(
                children: [
                  Image.network(
                    image,
                    width: double.infinity,
                    height: widthOrHeight ? 133.w / 3 : 133.h,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    right: 0,
                    top: 0.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0)),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.h, horizontal: 1.w),
                          color: AppColors.textgrey.withOpacity(
                              0.6), // Ubah opacitas untuk membuatnya tembus pandang
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.place,
                                size: 20.sp,
                                color: AppColors.red,
                              ),
                              TextHelper(
                                text: '<${distance} Km',
                                fontSize: 12.sp,
                                fontColor: AppColors.black,
                                fontFamily: FontFamily.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 7.h),
            rating != null
                ? RatingBarIndicator(
                    rating: rating ?? 0, // Rating yang ingin ditampilkan
                    itemPadding: EdgeInsets.zero,
                    itemCount: 5, // Jumlah bintang yang ingin ditampilkan
                    itemSize: 16.sp, // Ukuran bintang
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  )
                : Container(),
            SizedBox(height: 1.5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: TextHelper(
                text: topText,
                fontSize: 16.sp,
                fontFamily: FontFamily.bold,
                fontColor: AppColors.black,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 1.5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: TextHelper(
                text: midleText,
                fontSize: 12.sp,
                maxLines: 2,
                fontColor: AppColors.black,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(height: 7.h),
          ],
        ),
      ),
    );
  }
}
