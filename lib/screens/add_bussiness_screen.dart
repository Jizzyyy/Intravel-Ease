import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/providers/add_bussiness_provider.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';

class AddBussinessScreen extends StatefulWidget {
  const AddBussinessScreen({Key? key}) : super(key: key);

  @override
  _AddBussinessScreenState createState() => _AddBussinessScreenState();
}

class _AddBussinessScreenState extends State<AddBussinessScreen> {
  AddBussinessProvider initProvider = AddBussinessProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initProvider.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: initProvider,
        child:
            Consumer<AddBussinessProvider>(builder: (context, provider, child) {
          return WillPopScope(
            onWillPop: () async {
              EasyLoading.dismiss();
              return true;
            },
            child: Scaffold(
              key: provider.scaffoldKey,
              backgroundColor: AppColors.white,
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
                  text: 'Buat Toko Usaha',
                  fontSize: 20.sp,
                  fontFamily: FontFamily.bold,
                  fontColor: Colors.black,
                ),
              ),
              body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Form(
                  key: provider.formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 30.h, left: 0.w, right: 0.w),
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                await provider.pickImageFromGallery();
                              },
                              child: Column(
                                children: [
                                  Container(
                                    child: provider.pickedImage != null
                                        ? Image.file(
                                            provider.pickedImage!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/buttontambahusaha.png',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  SizedBox(height: 5.h),
                                  TextHelper(
                                    text: 'Tambahkan Gambar Usaha Anda',
                                    fontSize: 16.sp,
                                    fontFamily: FontFamily.regular,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 16.h, left: 16.w, right: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextHelper(
                                text: 'Apa nama toko usaha anda?',
                                fontSize: 15.sp,
                                fontFamily: FontFamily.bold,
                              ),
                              SizedBox(height: 10.h),
                              TextFormField(
                                controller: provider.namaController,
                                validator: (value) => provider.validatorConfirm(
                                    value, 'nama toko'),
                                decoration: InputDecoration(
                                  hintText: 'Tambahkan nama toko',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              TextHelper(
                                text: 'Apa produk yang anda tawarkan?',
                                fontSize: 15.sp,
                                fontFamily: FontFamily.bold,
                              ),
                              SizedBox(height: 5.h),
                              TextFormField(
                                controller: provider.produkController,
                                validator: (value) =>
                                    provider.validatorConfirm(value, 'produk'),
                                decoration: InputDecoration(
                                  hintText: 'Nama produk yang dijual',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              TextHelper(
                                text: 'Pilih kategori usaha anda!',
                                fontSize: 15.sp,
                                fontFamily: FontFamily.bold,
                              ),
                              SizedBox(height: 5.h),
                              DropdownButtonFormField(
                                validator: (value) {
                                  if (value == null) {
                                    return 'Pilih salah satu kategori produk'; // Pesan error yang akan ditampilkan jika dropdown tidak dipilih
                                  }
                                  return null; // Return null jika tidak ada error
                                },
                                value: provider.selectedValue,
                                hint: Text('Jenis kategori produk yang dijual'),
                                items: const [
                                  DropdownMenuItem(
                                    value: '1',
                                    child: Text('Makanan dan minuman'),
                                  ),
                                  DropdownMenuItem(
                                    value: '2',
                                    child: Text('Souvenir'),
                                  ),
                                  DropdownMenuItem(
                                    value: '3',
                                    child: Text('Oleh-oleh'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    provider.selectedValue = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              TextHelper(
                                text: 'Masukkan nomor kontak?',
                                fontSize: 15.sp,
                                fontFamily: FontFamily.bold,
                              ),
                              SizedBox(height: 5.h),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                maxLength: 13,
                                controller: provider.kontakController,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Isikan nomor kontak usaha anda';
                                  } else if (value.length < 12 ||
                                      value.length > 13) {
                                    return 'Masukkan nomor telepon yang valid';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Nomor kontak',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              TextHelper(
                                text: 'Deskripsi usaha',
                                fontSize: 15.0,
                                fontFamily: FontFamily.bold,
                              ),
                              SizedBox(height: 5.h),
                              TextFormField(
                                controller: provider.deskripsiController,
                                validator: (value) => provider.validatorConfirm(
                                    value, 'desripsi toko'),
                                textAlignVertical: TextAlignVertical.center,
                                maxLines: null,
                                minLines: 5,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: 'Tambahkan Deskripsi toko usaha',
                                  border: const OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.h,
                                    horizontal: 12.w,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),
                              TextHelper(
                                text: 'Tambahkan Lokasi',
                                fontSize: 15.sp,
                                fontFamily: FontFamily.bold,
                              ),
                              SizedBox(height: 5.h),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () => provider.toMap(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.black,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: TextHelper(
                                          text: provider.checkLocation
                                              ? provider.alamat
                                              : 'Pilih Lokasi Anda di Google Maps',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Icon(
                                        Icons.my_location,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.h),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    provider.buttonConfirm(context);
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                    child: TextHelper(
                                      text: 'Simpan',
                                      fontSize: 20.sp,
                                      fontFamily: FontFamily.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    minimumSize: Size(double.infinity, 20.h),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
