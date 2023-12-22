// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:intravel_ease/widgets/text_line_helper.dart';

import '../configs/app_color.dart';

class BoxSpot extends StatelessWidget {
  BoxSpot({
    required this.image,
    required this.topText,
    required this.midleText,
    required this.distance,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  String image;
  String topText;
  String midleText;
  String distance;
  VoidCallback onClick;

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
              child: Image.network(
                image,
                width: double.infinity,
                height: widthOrHeight ? 133.w / 3 : 133.h,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 7.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.place,
                  size: 20.sp,
                  color: AppColors.red,
                ),
                SizedBox(width: 3.w),
                TextHelper(
                  text: '<${distance} Km',
                  fontSize: 12.sp,
                  fontColor: AppColors.black,
                  fontFamily: FontFamily.bold,
                ),
              ],
            ),
            SizedBox(height: 1.5.h),
            LineTextHelper(
              text: topText,
              fontSize: 14.sp,
              fontFamily: FontFamily.bold,
              fontColor: AppColors.black,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 1.5.h),
            TextHelper(
              text: midleText,
              fontSize: 12.sp,
              fontColor: AppColors.black,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5.h),
            SizedBox(height: 7.h),
          ],
        ),
      ),
    );
  }
}
