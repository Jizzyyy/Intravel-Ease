import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/providers/change_password_provider.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _isPasswordVisible = false;
  bool _isPasswordVisibleBaru = false;
  bool _isPasswordVisibleKonfirmasi = false;

  void _togglePasswordVisibility(int fieldIndex) {
    setState(() {
      if (fieldIndex == 1) {
        _isPasswordVisible = !_isPasswordVisible;
      } else if (fieldIndex == 2) {
        _isPasswordVisibleBaru = !_isPasswordVisibleBaru;
      } else if (fieldIndex == 3) {
        _isPasswordVisibleKonfirmasi = !_isPasswordVisibleKonfirmasi;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangePasswordProvider(),
      child:
          Consumer<ChangePasswordProvider>(builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            EasyLoading.dismiss();
            return true;
          },
          child: Scaffold(
            key: provider.scaffoldKey,
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
                text: 'Ubah Kata Sandi',
                fontSize: 20.sp,
                fontFamily: FontFamily.bold,
                fontColor: Colors.black,
              ),
            ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Form(
                    key: provider.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.h),
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 120.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4.w,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2.r,
                                        blurRadius: 10.r,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage('assets/images/avatar.png'),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),
                            ],
                          ),
                        ),
                        SizedBox(height: 60.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextHelper(
                              text: 'Kata Sandi Lama',
                              fontSize: 18.sp,
                              fontFamily: FontFamily.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: TextFormField(
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'Masukkan kata sandi lama';
                              }
                              return null;
                            },
                            controller: provider.sandiLamaController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Kata Sandi Lama',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _togglePasswordVisibility(1);
                                },
                                child: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextHelper(
                              text: 'Masukkan Kata Sandi Baru',
                              fontSize: 18.sp,
                              fontFamily: FontFamily.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: TextFormField(
                            controller: provider.sandiBaruController,
                            obscureText: !_isPasswordVisibleBaru,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'Masukkan kata sandi baru';
                              }
                              if (value.toString().length < 8) {
                                return 'Kata sandi minimal 8 karakter';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Kata Sandi Baru',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _togglePasswordVisibility(2);
                                },
                                child: Icon(
                                  _isPasswordVisibleBaru
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextHelper(
                              text: 'Konfirmasi Kata Sandi',
                              fontSize: 18.sp,
                              fontFamily: FontFamily.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: TextFormField(
                            controller: provider.konfirmSandiController,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'Masukkan konfirmasi kata sandi baru';
                              }
                              return null;
                            },
                            obscureText: !_isPasswordVisibleKonfirmasi,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Konfirmasi Kata Sandi',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _togglePasswordVisibility(3);
                                },
                                child: Icon(
                                  _isPasswordVisibleKonfirmasi
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 60.h),
                        ElevatedButton(
                          onPressed: () {
                            provider.changePassword(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: TextHelper(
                              text: 'Simpan',
                              fontSize: 20.sp,
                              fontFamily: FontFamily.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                            minimumSize: Size(double.infinity, 20.h),
                          ),
                        ),
                        SizedBox(height: 10.h)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
