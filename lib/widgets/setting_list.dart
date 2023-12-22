// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/widgets/text_helper.dart';

import '../configs/app_color.dart';

class SettingList extends StatelessWidget {
  SettingList({
    required this.text,
    required this.icon,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  String text;
  IconData icon;
  VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.inputgrey,
      ),
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      child: GestureDetector(
        onTap: onClick,
        child: ListTile(
            leading: Icon(
              icon,
              color: AppColors.black,
            ),
            title: TextHelper(
              text: text,
              fontSize: 15.sp,
            ),
            trailing: const Icon(Icons.arrow_forward_ios)),
      ),
    );
  }
}
