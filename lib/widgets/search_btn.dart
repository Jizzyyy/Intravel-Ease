// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/widgets/text_helper.dart';

import '../configs/app_color.dart';

class SearchButton extends StatelessWidget {
  SearchButton({
    required this.onClick,
    required this.text,
    required this.haveContent,
    Key? key,
  }) : super(key: key);

  VoidCallback onClick;
  String text;
  bool haveContent = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.inputgrey,
        elevation: 2,
      ),
      onPressed: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: AppColors.textgrey,
            ),
            SizedBox(width: 6.w),
            haveContent
                ? TextHelper(
                    text: text,
                    fontSize: 15.sp,
                    fontFamily: FontFamily.semibold,
                    fontColor: AppColors.black,
                  )
                : TextHelper(
                    text: text,
                    fontSize: 15.sp,
                    fontColor: AppColors.textgrey,
                  )
          ],
        ),
      ),
    );
  }
}
