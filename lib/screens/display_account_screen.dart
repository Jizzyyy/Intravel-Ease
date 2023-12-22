import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/api_util.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/providers/display_account_provider.dart';
import 'package:intravel_ease/screens/edit_account_screen.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';
import 'package:intravel_ease/configs/app_color.dart';

class DisplayAccount extends StatefulWidget {
  const DisplayAccount({Key? key}) : super(key: key);

  @override
  State<DisplayAccount> createState() => _DisplayAccountState();
}

class _DisplayAccountState extends State<DisplayAccount> {
  DisplayAccountProvider initProvider = DisplayAccountProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: initProvider,
      child:
          Consumer<DisplayAccountProvider>(builder: (context, provider, child) {
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
              text: 'Akun Anda',
              fontSize: 20.sp,
              fontFamily: FontFamily.bold,
              fontColor: Colors.black,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: FutureBuilder(
                  future: provider.getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            width: 120.w,
                            height: 120.h,
                            child: ClipOval(
                              // backgroundColor: AppColors.white,
                              child: snapshot.data!.user_foto == null
                                  ? Image.asset(
                                      'assets/images/avatar.png',
                                      width: 120.w,
                                      height: 120.h,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      ApiUtil.urlBase +
                                          'storage/' +
                                          snapshot.data!.user_foto!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 50.h, horizontal: 20.w),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 18.sp,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 10.sp),
                                  TextHelper(
                                    text: 'Email',
                                    fontSize: 18.sp,
                                    fontFamily: FontFamily.bold,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 28.w),
                                child: Container(
                                  width: double.infinity,
                                  child: TextHelper(
                                    text: snapshot.data!.user_email,
                                    fontSize: 18.sp,
                                    fontFamily: FontFamily.medium,
                                  ),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey, // Warna garis
                                        width: 1.0, // Lebar garis
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 18.sp,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 10.sp),
                                    TextHelper(
                                      text: 'Nama Pengguna',
                                      fontSize: 18.sp,
                                      fontFamily: FontFamily.bold,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 28.w),
                                child: Container(
                                  width: double.infinity,
                                  child: TextHelper(
                                    text: snapshot.data!.user_nama,
                                    fontSize: 18.sp,
                                    fontFamily: FontFamily.medium,
                                  ),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey, // Warna garis
                                        width: 1.0, // Lebar garis
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 18.sp,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 10.sp),
                                    TextHelper(
                                      text: 'Nomor Telepon',
                                      fontSize: 18.sp,
                                      fontFamily: FontFamily.bold,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 28.w),
                                child: Container(
                                  width: double.infinity,
                                  child: TextHelper(
                                    text: snapshot.data!.user_telepon ??
                                        'Belum ada',
                                    fontSize: 18.sp,
                                    fontFamily: FontFamily.medium,
                                  ),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey, // Warna garis
                                        width: 1.0, // Lebar garis
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 18.sp,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 10.sp),
                                    TextHelper(
                                      text: 'Alamat',
                                      fontSize: 18.sp,
                                      fontFamily: FontFamily.bold,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 28.w),
                                child: Container(
                                  width: double.infinity,
                                  child: TextHelper(
                                    text: snapshot.data!.user_alamat ??
                                        'Belum ada',
                                    fontSize: 18.sp,
                                    fontFamily: FontFamily.medium,
                                  ),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey, // Warna garis
                                        width: 1.0, // Lebar garis
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.male,
                                      size: 18.sp,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 10.sp),
                                    TextHelper(
                                      text: 'Jenis Kelamin',
                                      fontSize: 18.sp,
                                      fontFamily: FontFamily.bold,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 28.w),
                                child: Container(
                                  width: double.infinity,
                                  child: TextHelper(
                                    text: snapshot.data!.user_gender ??
                                        'Belum ada',
                                    fontSize: 18.sp,
                                    fontFamily: FontFamily.medium,
                                  ),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey, // Warna garis
                                        width: 1.0, // Lebar garis
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 45.h),
                                child: SizedBox(
                                  width: 220.w,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.r)),
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EditAccount()),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.h),
                                        child: TextHelper(
                                          text: 'Edit Profil',
                                          fontSize: 20.sp,
                                          fontFamily: FontFamily.bold,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.secondary,
                                        minimumSize:
                                            Size(double.infinity, 20.h),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        );
      }),
    );
  }
}
