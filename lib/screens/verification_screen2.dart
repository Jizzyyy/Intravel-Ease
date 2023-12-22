import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:intravel_ease/providers/verification_provider2.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';

class VerificationScreen2 extends StatefulWidget {
  const VerificationScreen2({Key? key}) : super(key: key);

  @override
  State<VerificationScreen2> createState() => _VerificationScreen2State();
}

class _VerificationScreen2State extends State<VerificationScreen2> {
  String? kode;
  final TextEditingController otp = TextEditingController();
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
      create: (context) => Verification2Provider(),
      child:
          Consumer<Verification2Provider>(builder: (context, provider, child) {
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
                        text: "Verifikasi Akun",
                        fontSize: 20.sp,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.w700),
                  ],
                ),
              )),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20.h, left: 30.w, right: 30.w),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(
                        width: 150.w,
                        height: 100.h,
                        child: TextHelper(
                            text: "OTP Verifikasi!",
                            fontSize: 29.sp,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5.h),
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/otp.png",
                        width: 200.w, height: 200.h),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.h),
                    height: 100.h,
                    child: TextHelper(
                        text:
                            "Masukkan Kode Verifikasi yang telah kami kirimkan ke Alamat Email Anda",
                        fontSize: 16.sp,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: PinCodeTextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      controller: otp,
                      appContext: context,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Kode OTP tidak boleh kosong';
                        }
                      },
                      length: 4, // panjang kode OTP
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          kode = value;
                        });
                      },
                      cursorColor: Colors.black,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 60,
                          fieldWidth: 60,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.grey.shade100,
                          activeColor: Colors.grey.shade300,
                          inactiveColor: Colors.grey.shade300,
                          selectedColor:
                              const Color.fromARGB(255, 63, 187, 192),
                          selectedFillColor: Colors.white,
                          borderWidth: 1.5),
                      animationDuration: const Duration(milliseconds: 300),
                      textStyle:
                          TextStyle(fontFamily: 'nunito-r', fontSize: 18.sp),
                      enableActiveFill: true,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextHelper(
                        text: 'Belum Mendapatkan Kode?',
                        fontSize: 16.sp,
                        fontColor: Colors.black,
                      ),
                      TextButton(
                          onPressed: () async {
                            myauth.setConfig(
                                appEmail: "kadhafinaufal2@gmail.com",
                                appName: "InTravel Ease",
                                // userEmail: _emailController.text,
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
                              Navigator.of(context).push(
                                  PageAnimationTransition(
                                      page: const VerificationScreen2(),
                                      pageAnimationType:
                                          RightToLeftFadedTransition()));
                            }
                          },
                          child: TextHelper(
                              text: "Kirim Ulang",
                              fontSize: 16.sp,
                              fontColor:
                                  const Color.fromARGB(255, 63, 187, 192),
                              fontWeight: FontWeight.w800,
                              fontFamily: 'nunito-r')),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    padding: EdgeInsets.only(top: 10.h, bottom: 50.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (await myauth.verifyOTP(otp: kode) == true) {
                            AnimatedSnackBar.rectangle(
                              'Sukses',
                              'Kode OTP Berhasil Dikirim',
                              type: AnimatedSnackBarType.success,
                              brightness: Brightness.light,
                            ).show(
                              context,
                            );
                            Navigator.of(context).push(PageAnimationTransition(
                                page: const VerificationScreen2(),
                                pageAnimationType:
                                    RightToLeftFadedTransition()));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Invalid OTP"),
                            ));
                          }
                          // Navigator.of(context).push(PageTransition(
                          //     child: const ResetPassword(),
                          //     reverseDuration:
                          //         const Duration(milliseconds: 200),
                          //     duration: const Duration(milliseconds: 500),
                          //     alignment: Alignment.bottomCenter,
                          //     type: PageTransitionType.size));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: TextHelper(
                            text: 'Verifikasi',
                            fontSize: 20.sp,
                            fontFamily: FontFamily.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
