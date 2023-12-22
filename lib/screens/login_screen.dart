import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/providers/login_provider.dart';
import 'package:intravel_ease/screens/register_screen.dart';
import 'package:intravel_ease/widgets/passwordfield_helper.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:intravel_ease/widgets/textfield_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Form(
              key: provider.formKey,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(children: [
                  //!start header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(70.r),
                            bottomRight: Radius.circular(70.r)),
                        color: AppColors.black),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).padding.top + 10.h),
                          TextHelper(
                            text: 'Intravel Ease',
                            fontSize: 30.sp,
                            fontColor: AppColors.white,
                            fontFamily: FontFamily.semibold,
                          ),
                          SizedBox(height: 12.h),
                          TextHelper(
                            text:
                                'Selamat datang kembali! Masuk ke akun Anda dengan mudah menggunakan layanan kami. Bergabunglah kembali dengan komunitas kami dan nikmati manfaat penuh dari layanan kami.',
                            fontSize: 15.sp,
                            fontColor: AppColors.white,
                            fontFamily: FontFamily.semibold,
                          ),
                          SizedBox(height: 50.h),
                        ]),
                  ),
                  //?end header
                  SizedBox(height: 34.h),
                  TextHelper(
                      text: 'Masuk',
                      fontSize: 28.sp,
                      fontFamily: FontFamily.semibold),
                  SizedBox(height: 58.h),
                  //!start email & password
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3) // Ubah offset sesuai kebutuhan
                              )
                        ]),
                        child: TextFieldHelper(
                          controller: provider.emailController,
                          hintText: 'Email',
                          borderRadius: 10.r,
                          prefixIcon: const Icon(Icons.email),
                          inputFormatter: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: PasswordFieldHelper(
                            controller: provider.passwordController,
                            hintText: 'Password',
                            borderRadius: 10.r,
                            prefixIcon: const Icon(Icons.lock),
                            suffixOnTap: () {
                              provider.togglePasswordVisibility();
                            },
                            obscureText: provider.isPasswordVisible),
                      )
                    ]),
                  ),
                  //?end email & password
                  SizedBox(height: 22.h),
                  //!start btn lupa kata sandi
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.of(context).push(PageTransition(
                  //         child: const ForgotPassword(),
                  //         reverseDuration: const Duration(milliseconds: 200),
                  //         duration: const Duration(milliseconds: 500),
                  //         alignment: Alignment.bottomCenter,
                  //         type: PageTransitionType.size));
                  //   },
                  //   child: TextHelper(
                  //     text: 'Lupa Kata Sandi',
                  //     fontSize: 18.sp,
                  //     fontFamily: FontFamily.bold,
                  //   ),
                  // ),
                  //?end btn lupa kata sandi
                  SizedBox(height: 32.h),
                  //!start btn masuk
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15.r)),
                      child: ElevatedButton(
                        onPressed: () => provider.buttonLogin(context),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: TextHelper(
                            text: 'Masuk',
                            fontSize: 20.sp,
                            fontFamily: FontFamily.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //?end btn masuk
                  SizedBox(height: 64.h),
                  //!start btn daftar
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Belum Punya Akun? ",
                          style: TextStyle(
                              color: AppColors.black,
                              fontFamily: FontFamily.medium,
                              fontSize: 18.sp)),
                      TextSpan(
                          text: "Daftar",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(PageTransition(
                                  child: RegisterScreen(),
                                  reverseDuration:
                                      const Duration(milliseconds: 200),
                                  duration: const Duration(milliseconds: 500),
                                  alignment: Alignment.bottomCenter,
                                  type: PageTransitionType.size));
                            },
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.black,
                            fontFamily: FontFamily.bold,
                            decoration: TextDecoration.underline,
                          ))
                    ])),
                  ),
                  //?end btn daftar
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
