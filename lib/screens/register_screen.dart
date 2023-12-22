import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/providers/register_provider.dart';
import 'package:intravel_ease/widgets/passwordfield_helper.dart';
import 'package:intravel_ease/widgets/textfield_helper.dart';
import 'package:provider/provider.dart';
import '../configs/app_color.dart';
import '../configs/font_family.dart';
import '../widgets/text_helper.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: Consumer<RegisterProvider>(builder: (context, provider, child) {
        return Scaffold(
          body: Form(
            key: provider.formKey,
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  //! start header
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        12.w, MediaQuery.of(context).padding.top, 12.w, 71.h),
                    color: AppColors.black,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextHelper(
                          text: 'Daftar',
                          fontSize: 28.sp,
                          fontFamily: FontFamily.semibold,
                          fontColor: AppColors.white,
                        ),
                        SizedBox(height: 17.h),
                        TextHelper(
                          text:
                              'Intravel-Ease, aplikasi perjalanan yang inovatif, Anda dapat merencanakan perjalanan impian Anda dengan mudah, mengakses informasi destinasi terkini, dan mengatur jadwal.',
                          fontSize: 13.sp,
                          fontFamily: FontFamily.semibold,
                          fontColor: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 58.h.h),
                  //? end header
                  //! start input field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //!start nama depan
                        TextHelper(
                          text: 'Nama',
                          fontSize: 13.sp,
                          fontFamily: FontFamily.bold,
                        ),
                        SizedBox(height: 4.h),
                        TextFieldHelper(
                          controller: provider.namaController,
                          hintText: 'Hanya huruf',
                          borderRadius: 4.r,
                          filled: false,
                          borderSide: const BorderSide(),
                          validator: provider.validatorNama,
                          inputFormatter: [
                            // FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z\s]')),
                          ],
                        ),
                        //?end nama depan

                        SizedBox(height: 32.h),
                        //!start nama email
                        TextHelper(
                          text: 'Email',
                          fontSize: 13.sp,
                          fontFamily: FontFamily.bold,
                        ),
                        SizedBox(height: 4.h),
                        TextFieldHelper(
                          controller: provider.emailController,
                          hintText: 'Email anda',
                          borderRadius: 4.r,
                          filled: false,
                          borderSide: const BorderSide(),
                          validator: provider.validatorEmail,
                          inputFormatter: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                        ),
                        //?end email
                        SizedBox(height: 32.h),

                        //!start kata sandi
                        TextHelper(
                          text: 'Kata Sandi',
                          fontSize: 13.sp,
                          fontFamily: FontFamily.bold,
                        ),
                        SizedBox(height: 4.h),
                        PasswordFieldHelper(
                          controller: provider.passwordController,
                          obscureText: provider.isPasswordVisible,
                          suffixOnTap: () =>
                              provider.togglePasswordVisibility(),
                          hintText: 'Minimal 8 karakter',
                          borderRadius: 4.r,
                          filled: false,
                          borderSide: const BorderSide(),
                          validator: provider.validatorPassword,
                        ),
                        //?end kata sandi
                        SizedBox(height: 32.h),
                        //!start konfirmasi sandi
                        TextHelper(
                          text: 'Konfirmasi Kata Sandi',
                          fontSize: 13.sp,
                          fontFamily: FontFamily.bold,
                        ),
                        SizedBox(height: 4.h),
                        PasswordFieldHelper(
                          controller: provider.confirmpasswordController,
                          obscureText: provider.isConfirmVisible,
                          suffixOnTap: () => provider.toggleConfirmVisibility(),
                          hintText: 'Minimal 8 karakter',
                          borderRadius: 4.r,
                          filled: false,
                          borderSide: const BorderSide(),
                          validator: provider.validatorConfirm,
                        ),
                        //?end konfirmasi sandi
                        SizedBox(height: 64.h),
                        //!start btn register
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              provider.buttonRegister(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 11.h),
                              child: TextHelper(
                                text: 'Daftar',
                                fontSize: 20.sp,
                                fontFamily: FontFamily.bold,
                              ),
                            ),
                          ),
                        ),
                        //? end btn register
                        SizedBox(height: 65.h),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Sudah punya akun? ",
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontFamily: FontFamily.medium,
                                    fontSize: 18.sp)),
                            TextSpan(
                                text: "Masuk",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                  },
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppColors.black,
                                  fontFamily: FontFamily.bold,
                                  decoration: TextDecoration.underline,
                                ))
                          ])),
                        ),
                        SizedBox(height: 43.h),
                      ],
                    ),
                  ),
                  //?end input field
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
