// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/widgets/text_helper.dart';

import '../configs/app_color.dart';
import '../configs/font_family.dart';

class BoxCulinary extends StatelessWidget {
  BoxCulinary({
    required this.image,
    required this.topText,
    required this.midleText,
    required this.bottomText,
    required this.icon,
    this.onClick,
    this.iconColor,
    this.distance,
    Key? key,
  }) : super(key: key);

  String image;
  String topText;
  String midleText;
  String bottomText;
  IconData icon;
  Color? iconColor;
  String? distance;
  VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    final bool widthOrHeight =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    return Container(
      width: widthOrHeight ? 155.w / 3 : 155.h,
      margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.h),
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          shadowColor: Colors.grey.withOpacity(0.5),
          elevation: 4,
          padding: EdgeInsets.symmetric(horizontal: 6.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
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
                  )
                ],
              ),
            ),
            SizedBox(height: 7.h),
            SizedBox(
              height: 38.sp,
              child: TextHelper(
                text: topText,
                fontSize: 14.sp,
                fontColor: AppColors.black,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            // LineTextHelper(
            //   text: topText,
            //   fontSize: 14.sp,
            //   fontColor: AppColors.black,
            //   overflow: TextOverflow.ellipsis,
            //   maxLines: 2,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 20.sp,
                  color: iconColor ?? AppColors.black,
                ),
                SizedBox(width: 3.w),
                midleText.trim() == 'null'
                    ? TextHelper(
                        text: 'Belum ada',
                        fontSize: 13.sp,
                        fontColor: AppColors.black,
                      )
                    : TextHelper(
                        text: midleText,
                        fontSize: 12.sp,
                        fontColor: AppColors.black,
                      ),
              ],
            ),
            SizedBox(height: 5.h),
            TextHelper(
              text: bottomText,
              fontSize: 15.sp,
              fontColor: AppColors.secondary,
              fontFamily: FontFamily.semibold,
            ),
            SizedBox(height: 7.h),
          ],
        ),
      ),
    );
  }
}
