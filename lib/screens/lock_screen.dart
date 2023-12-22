import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:page_transition/page_transition.dart';

import 'login_screen.dart';

class LockScreen extends StatelessWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg_lock.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 15.w,
            right: 15.w,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextHelper(
                    text: 'Temukan tempat terbaik di sekitarmu!',
                    fontSize: 40.sp,
                    fontFamily: FontFamily.bold,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 17.h),
                  TextHelper(
                    text:
                        'Rencanakan perjalanan wisata dengan mudah menggunakan layanan kami',
                    fontSize: 16.sp,
                    fontFamily: FontFamily.bold,
                  ),
                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15.r)),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(PageTransition(
                              child: const LoginScreen(),
                              duration: const Duration(milliseconds: 500),
                              alignment: Alignment.bottomCenter,
                              type: PageTransitionType.rightToLeftWithFade));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: TextHelper(
                            text: 'Mulai',
                            fontSize: 20.sp,
                            fontFamily: FontFamily.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
