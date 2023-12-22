import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/providers/forgot_password_provider.dart';
import 'package:intravel_ease/screens/verification_screen2.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:provider/provider.dart';
import 'package:email_otp/email_otp.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  EmailOTP myauth = EmailOTP();

  @override
  void initState() {
    super.initState();
    myauth.setSMTP(
        host: "smtp.gmail.com",
        auth: true,
        username: "intraveleasev@gmail.com",
        password: "fikyeusxrfmhnbhx",
        secure: "TLS",
        port: 587);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgotPasswordProvider(),
      child: Consumer(builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: TextHelper(
              text: 'Lupa Kata Sandi',
              fontSize: 20.sp,
              fontFamily: FontFamily.bold,
              fontColor: Colors.black,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50.h),
                    Center(
                      child: Image.asset(
                        "assets/images/email.png",
                        height: 220.h,
                        width: 220.w,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Container(
                      padding: EdgeInsets.only(top: 15.h),
                      height: 100.h,
                      child: TextHelper(
                          text:
                              "Masukkan Email terlebih dahulu untuk melakukan verifikasi OTP",
                          fontSize: 17.sp,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 4.h, left: 18.w, right: 18.w),
                      height: 55.h,
                      width: 340.w,
                      child: TextFormField(
                        controller: _emailController,
                        style: TextStyle(fontSize: 17.sp, color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.black),
                          hintText: "Masukkan Email",
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
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      padding: EdgeInsets.only(top: 50.h, bottom: 50.h),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        child: ElevatedButton(
                          onPressed: () async {
                            myauth.setConfig(
                                appEmail: "kadhafinaufal2@gmail.com",
                                appName: "InTravel Ease",
                                userEmail: _emailController.text,
                                otpLength: 4,
                                otpType: OTPType.digitsOnly);
                            if (await myauth.sendOTP() == true) {
                              AnimatedSnackBar.rectangle(
                                'Sukses',
                                'Kode OTP Berhasil Dikirim',
                                type: AnimatedSnackBarType.success,
                                brightness: Brightness.light,
                              ).show(
                                context,
                              );
                              Navigator.of(context).push(PageAnimationTransition(page: const VerificationScreen2(), pageAnimationType: RightToLeftFadedTransition()));
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: TextHelper(
                              text: 'Kirim',
                              fontSize: 20.sp,
                              fontFamily: FontFamily.bold,
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
