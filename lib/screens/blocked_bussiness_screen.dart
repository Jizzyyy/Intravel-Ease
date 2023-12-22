import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/font_family.dart';

import '../widgets/text_helper.dart';

class BlockedBussinessScreen extends StatelessWidget {
  const BlockedBussinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextHelper(
          text: 'Usaha Anda',
          fontSize: 20.0,
          fontFamily: FontFamily.bold,
          fontColor: Colors.black,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/img_blocked.png',
              width: 200.w,
              height: 200.h,
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: TextHelper(
              text: 'Usaha Anda Telah DIblokir',
              fontSize: 18.sp,
              fontFamily: FontFamily.bold,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: TextHelper(
              text: 'Coba hubungi admin untuk mengaktifkan kembali usaha anda',
              fontSize: 18.sp,
              textAlign: TextAlign.center,
              fontFamily: FontFamily.medium,
            ),
          ),
          SizedBox(height: 50),
          Container(
            width: 250,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40),
              ),
              child: TextHelper(
                text: 'Kembali',
                fontSize: 20.sp,
                fontFamily: FontFamily.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
