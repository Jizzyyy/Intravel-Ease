import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/api_util.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/providers/edit_account_provider.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditAccountProvider(),
      child: Consumer<EditAccountProvider>(builder: (context, provider, child) {
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
                text: 'Edit Akun Anda',
                fontSize: 20.sp,
                fontFamily: FontFamily.bold,
                fontColor: Colors.black,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
                child: FutureBuilder(
                    future: provider.getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Form(
                        key: provider.formKey,
                        child: Column(
                          children: [
                            Center(
                              child: Stack(
                                children: [
                                  ClipOval(
                                      child: provider.pickedImage != null
                                          ? Image.file(
                                              provider.pickedImage!,
                                              fit: BoxFit.cover,
                                              width: 120.w,
                                              height: 120.h,
                                            )
                                          : snapshot.data?.user_foto != null
                                              ? Image.network(
                                                  ApiUtil.urlBase +
                                                      'storage/' +
                                                      snapshot.data!.user_foto!,
                                                  fit: BoxFit.cover,
                                                  width: 120.w,
                                                  height: 120.h,
                                                )
                                              : Image.asset(
                                                  'assets/images/avatar.png',
                                                  width: 120.w,
                                                  height: 120.h,
                                                  fit: BoxFit.cover,
                                                )),
                                  // Container(
                                  //   width: 140.w,
                                  //   height: 140.h,
                                  //   decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //         width: 4.w,
                                  //         color: Theme.of(context)
                                  //             .scaffoldBackgroundColor),
                                  //     boxShadow: [
                                  //       BoxShadow(
                                  //           spreadRadius: 2.r,
                                  //           blurRadius: 10.r,
                                  //           color:
                                  //               Colors.black.withOpacity(0.1),
                                  //           offset: const Offset(0, 10))
                                  //     ],
                                  //     shape: BoxShape.circle,
                                  //     // image: provider.pickedImage != null
                                  //     //     ? DecorationImage(
                                  //     //         fit: BoxFit.cover,
                                  //     //         image: FileImage(File(
                                  //     //             provider.pickedImage!.path)),
                                  //     //       )
                                  //     //     : const DecorationImage(
                                  //     //         fit: BoxFit.cover,
                                  //     //         image: Image.asset(''),
                                  //     //         // image: AssetImage(
                                  //     //         //     'assets/images/avatar.png'),
                                  //     //       ),
                                  //   ),
                                  // ),
                                  SizedBox(height: 50.h),
                                  Positioned(
                                    bottom: 0.h,
                                    right: 0.h,
                                    child: Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 3.w,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                        color: Colors.blue,
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20.h,
                                          ),
                                          onPressed:
                                              provider.pickImageFromGallery,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 18.h),
                            TextHelper(
                              text: snapshot.data!.user_email,
                              fontSize: 16.sp,
                              fontFamily: FontFamily.bold,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 40.h, left: 12.w),
                              child: Row(
                                children: [
                                  TextHelper(
                                    text: 'Nama Pengguna',
                                    fontSize: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 12.w),
                              child: TextFormField(
                                controller: provider.namaController,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Isikan nama';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Masukkan nama',
                                  hintStyle: TextStyle(fontSize: 16.sp),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.h, left: 12.w),
                              child: Row(
                                children: [
                                  TextHelper(
                                    text: 'Nomor Telepon',
                                    fontSize: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 12.w),
                              child: TextFormField(
                                maxLength: 13,
                                controller: provider.teleponController,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Isikan nomor telepon';
                                  } else if (value!.length < 12) {
                                    return 'Masukkan nomor telepon yang valid';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Masukkan nomor telepon',
                                  hintStyle: TextStyle(fontSize: 16.sp),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.h, left: 12.w),
                              child: Row(
                                children: [
                                  TextHelper(
                                    text: 'Jenis Kelamin',
                                    fontSize: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 12.w),
                              child: DropdownButtonFormField(
                                validator: (value) {
                                  if (value == null) {
                                    return 'Pilih jenis kelamin anda'; // Pesan error yang akan ditampilkan jika dropdown tidak dipilih
                                  }
                                  return null; // Return null jika tidak ada error
                                },
                                value: provider.selectedValue,
                                hint: Text('Jenis Kelamin'),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'L',
                                    child: Text('Laki-laki'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'P',
                                    child: Text('Perempuan'),
                                  ),
                                ],
                                onChanged: (value) {
                                  provider.selectedValue = value;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.h, left: 12.w),
                              child: Row(
                                children: [
                                  TextHelper(
                                    text: 'Alamat',
                                    fontSize: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 12.w),
                              child: TextFormField(
                                controller: provider.alamatController,
                                textAlignVertical: TextAlignVertical.center,
                                maxLines: 5,
                                minLines: null,
                                textAlign: TextAlign.left,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Isikan alamat';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Masukkan alamat',
                                  border: const OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 12.w),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 25.h),
                              child: SizedBox(
                                width: 220.w,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.r)),
                                  child: ElevatedButton(
                                    onPressed: () => provider.buttonKu(context),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.h),
                                      child: TextHelper(
                                        text: 'Ubah Akun',
                                        fontSize: 20.sp,
                                        fontFamily: FontFamily.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.black,
                                      minimumSize: Size(double.infinity, 20.h),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ),
        );
      }),
    );
  }
}
