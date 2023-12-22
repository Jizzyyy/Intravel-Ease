import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/providers/reset_password_provider.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ResetPasswordProvider(),
      child: Consumer(builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                padding: EdgeInsets.only(left: 20.w),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Container(
                padding: EdgeInsets.only(left: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHelper(
                        text: "Ubah Kata Sandi",
                        fontSize: 20.sp,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.w700),
                  ],
                ),
              )),
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.h),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 15.h),
                      child: TextHelper(
                          text:
                              "Masukkan Kode OTP yang sudah dikirimkan Email Anda",
                          fontSize: 17.sp,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(height: 50.h),
                    Container(
                      padding: EdgeInsets.only(top: 5.h),
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/changepw.png",
                          width: 170.w, height: 170.h),
                    ),
                    SizedBox(height: 80.h),
                    Container(
                      padding:
                          EdgeInsets.only(top: 4.h, left: 18.w, right: 18.w),
                      height: 55.h,
                      width: 350.w,
                      child: TextFormField(
                        style: TextStyle(fontSize: 17.sp, color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: "Masukkan Password Baru",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 16.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding:
                          EdgeInsets.only(top: 4.h, left: 18.w, right: 18.w),
                      height: 55.h,
                      width: 350.w,
                      child: TextFormField(
                        style: TextStyle(fontSize: 17.sp, color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: "Konfirmasi Password",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 16.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      padding: EdgeInsets.only(top: 10.h, bottom: 50.h),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(PageTransition(
                                child: const ResetPassword(),
                                reverseDuration:
                                    const Duration(milliseconds: 200),
                                duration: const Duration(milliseconds: 500),
                                alignment: Alignment.bottomCenter,
                                type: PageTransitionType.size));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: TextHelper(
                              text: 'Ubah Password',
                              fontSize: 20.sp
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        );
      }),
    );
  }
}
