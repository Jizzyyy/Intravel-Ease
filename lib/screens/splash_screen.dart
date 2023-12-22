import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/screens/lock_screen.dart';
import 'package:intravel_ease/screens/navigation_screen.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> fetchData() async {
    await Navigator.of(context).pushReplacement(PageTransition(
        child: const LockScreen(),
        reverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.bottomCenter,
        type: PageTransitionType.size));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset('assets/images/logo_intravel_ease.png')],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        child: ListView(
          shrinkWrap: true,
          children: [
            TextHelper(
              text: 'from',
              fontSize: 14.sp,
              textAlign: TextAlign.center,
              fontColor: AppColors.textgrey,
            ),
            TextHelper(
              text: 'Star Light',
              fontSize: 20.sp,
              textAlign: TextAlign.center,
              fontFamily: FontFamily.semibold,
            ),
            SizedBox(height: 20.h)
          ],
        ),
      ),
    );
  }
}
