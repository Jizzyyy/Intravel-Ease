import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/widgets/null_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDetail extends StatelessWidget {
  const ShimmerDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLine(width: double.infinity, height: 250.h),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.only(top: 15.h, left: 18.w),
                child: ShimmerLine(
                  height: 22.h,
                  width: 150.w,
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                  padding: EdgeInsets.only(left: 18.w),
                  child: ShimmerLine(
                    width: 200.w,
                    height: 30.sp,
                  )),
              SizedBox(height: 3.h),
              Container(
                padding: EdgeInsets.only(left: 18.w),
                child: ShimmerLine(
                  width: 250.w,
                  height: 14.h,
                ),
              ),
              SizedBox(height: 3.h),
              Container(
                padding: EdgeInsets.only(left: 18.w),
                child: ShimmerLine(
                  width: 250.w,
                  height: 14.h,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.only(left: 18.w, right: 18.w),
                child: ShimmerLine(
                  height: 200.h,
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.only(top: 15.h, left: 18.w),
                child: ShimmerLine(
                  height: 22.h,
                  width: 150.w,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.only(left: 18.w, right: 18.w),
                child: ShimmerLine(
                  height: 22.h,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.only(left: 18.w, right: 18.w),
                child: ShimmerLine(
                  height: 22.h,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.only(left: 18.w, right: 18.w),
                child: ShimmerLine(
                  height: 22.h,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.only(left: 18.w, right: 18.w),
                child: ShimmerLine(
                  height: 22.h,
                ),
              ),
            ],
          ),
        ),
        baseColor: AppColors.inputgrey,
        highlightColor: AppColors.textgrey);
  }
}
