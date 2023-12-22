import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:shimmer/shimmer.dart';

class NullShimmer extends StatelessWidget {
  const NullShimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool widthOrHeight =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    return Container(
      width: widthOrHeight ? 155.w / 3 : 155.h,
      margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.h),
      child: ElevatedButton(
        onPressed: () {},
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
              child: ShimmerLine(
                  width: double.infinity,
                  height: widthOrHeight ? 133.w / 3 : 133.h),
            ),
            SizedBox(height: 7.h),
            ShimmerLine(
                width: MediaQuery.of(context).size.width / 2, height: 20.sp),
            SizedBox(height: 1.5.h),
            ShimmerLine(width: 90.w, height: 14.sp),
            SizedBox(height: 1.5.h),
            ShimmerLine(width: 110.w, height: 12.sp),
            SizedBox(height: 5.h),
            SizedBox(height: 7.h),
          ],
        ),
      ),
    );
  }
}

class ShimmerLine extends StatelessWidget {
  final double width;
  final double height;

  ShimmerLine({this.width = double.infinity, this.height = 20});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: AppColors.inputgrey,
        highlightColor: AppColors.textgrey,
        child: Container(
          color: AppColors.white,
        ),
      ),
    );
  }
}
