import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:intravel_ease/providers/verification_provider.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  VerificationProvider initProvider = VerificationProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        initProvider.buttonSend(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: initProvider,
      child:
          Consumer<VerificationProvider>(builder: (context, provider, child) {
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        controller: provider.otpController,
                        appContext: context,
                        length: 4, // panjang k
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
                            onPressed: () {
                              provider.buttonSend(context);
                              // provider.sendOtp(context);
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
                    Container(
                      width: 200.w,
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      padding: EdgeInsets.only(top: 10.h, bottom: 50.h),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15.r)),
                        child: ElevatedButton(
                          onPressed: () {
                            provider.buttonVerifikasi(context);
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
          ),
        );
      }),
    );
  }
}
