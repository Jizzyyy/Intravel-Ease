import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/providers/add_product_provider.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  AddProductProvider initProvider = AddProductProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: initProvider,
        child:
            Consumer<AddProductProvider>(builder: (context, provider, child) {
          return Scaffold(
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
                text: 'Tambah Produk',
                fontSize: 20.sp,
                fontFamily: FontFamily.bold,
                fontColor: Colors.black,
              ),
            ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Form(
                key: provider.formKey,
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    TextHelper(
                      text: 'Gambar Produk',
                      fontSize: 20.sp,
                      fontFamily: FontFamily.bold,
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () async {
                        await provider.pickImageFromGallery();
                      },
                      child: provider.pickedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.file(
                                provider.pickedImage!,
                                fit: BoxFit.contain,
                                width: 200.w,
                                height: 200.h,
                              ),
                            )
                          : Image.asset(
                              'assets/images/buttontambahusaha.png',
                              fit: BoxFit.contain,
                              width: 200.w,
                              height: 200.h,
                            ),
                    ),
                    SizedBox(height: 40.h),
                    TextHelper(
                      text: 'Nama Produk',
                      fontSize: 18.sp,
                      fontFamily: FontFamily.bold,
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: TextFormField(
                        validator: (value) =>
                            provider.validatorConfirm(value, 'nama produk'),
                        controller: provider.namaController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Nama Produk',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    TextHelper(
                      text: 'Harga(Rupiah)',
                      fontSize: 18.0,
                      fontFamily: FontFamily.bold,
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: TextFormField(
                        validator: (value) =>
                            provider.validatorConfirm(value, 'harga'),
                        keyboardType: TextInputType.number,
                        controller: provider.hargaController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Harga Produk',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 60.h),
                    ElevatedButton(
                      onPressed: () => provider.saveProduct(context),
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: TextHelper(
                          text: 'Simpan Produk',
                          fontSize: 19.sp,
                          fontFamily: FontFamily.semibold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
