import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/api_util.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/providers/manage_bussiness_provider.dart';
import 'package:intravel_ease/widgets/null_shimmer.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ManageBussinessScreen extends StatefulWidget {
  const ManageBussinessScreen({Key? key}) : super(key: key);

  @override
  State<ManageBussinessScreen> createState() => _ManageBussinessScreenState();
}

class _ManageBussinessScreenState extends State<ManageBussinessScreen> {
  ManageBussinessProvider initProvider = ManageBussinessProvider();

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
      child: Consumer<ManageBussinessProvider>(
        builder: (context, provider, child) {
          return WillPopScope(
            onWillPop: () async {
              EasyLoading.dismiss();
              return true;
            },
            child: Scaffold(
              key: provider.scaffoldKey,
              body: Form(
                key: provider.formKey,
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Stack(
                            children: [
                              provider.pickedImage != null
                                  ? Image.file(
                                      provider.pickedImage!,
                                      width: double.infinity,
                                      height: 300.h,
                                      fit: BoxFit.contain,
                                    )
                                  : Image.network(
                                      ApiUtil.urlBase +
                                          'storage/' +
                                          provider.usahaModel!.usaha_gambar!,
                                      width: double.infinity,
                                      height: 300.h,
                                      fit: BoxFit.contain,
                                    ),
                              Positioned(
                                bottom: 0.h,
                                right: 10.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.inputgrey,
                                  ),
                                  onPressed: () async {
                                    await provider.pickImageFromGallery();
                                  },
                                  child: TextHelper(
                                    text: 'Ganti Gambar',
                                    fontSize: 14.sp,
                                    fontColor: AppColors.black,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20.h,
                                left: 10.h,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: TextHelper(
                              text: 'Nama Usaha',
                              fontSize: 18.sp,
                              fontFamily: FontFamily.medium,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: TextFormField(
                              validator: (value) =>
                                  provider.validatorConfirm(value, 'nama toko'),
                              controller: provider.namaController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Masukkan Nama Usaha',
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: TextHelper(
                              text: 'Produk',
                              fontSize: 18.sp,
                              fontFamily: FontFamily.medium,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: TextFormField(
                              validator: (value) =>
                                  provider.validatorConfirm(value, 'procuk'),
                              controller: provider.produkController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Masukkan Produk',
                              ),
                            ),
                          ),
                          SizedBox(height: 18),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: TextHelper(
                              text: 'Nomor Kontak',
                              fontSize: 18.0,
                              fontFamily: FontFamily.medium,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              maxLength: 13,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Isikan nomor kontak usaha anda';
                                } else if (value.length < 12 ||
                                    value.length > 13) {
                                  return 'Masukkan nomor telepon yang valid';
                                }
                                return null;
                              },
                              controller: provider.contactController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Masukkan Nomor Kontak Usaha',
                              ),
                            ),
                          ),
                          SizedBox(height: 18),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: TextHelper(
                              text: 'Kategori Usaha',
                              fontSize: 18.0,
                              fontFamily: FontFamily.medium,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: DropdownButtonFormField(
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
                                // setState(() {
                                provider.selectedValue = value;
                                // });
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: TextHelper(
                              text: 'Deskripsi usaha',
                              fontSize: 18.0,
                              fontFamily: FontFamily.medium,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: TextFormField(
                              validator: (value) =>
                                  provider.validatorConfirm(value, 'deskripsi'),
                              controller: provider.deskripsiController,
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: null,
                              minLines: 5,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: 'Tambahkan deskripsi toko usaha',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 10.w),
                              ),
                            ),
                          ),
                          SizedBox(height: 25.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: TextHelper(
                              text: 'Lokasi Usaha',
                              fontSize: 15.sp,
                              fontFamily: FontFamily.bold,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Center(
                            child: Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.w, vertical: 10.h),
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => provider.toMap(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.inputgrey,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.h),
                                        child: TextHelper(
                                          text: provider.alamat,
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 16.sp,
                                          fontColor: AppColors.black,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.my_location,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Center(
                            child: ElevatedButton(
                                onPressed: () =>
                                    provider.buttonConfirm(context),
                                child: TextHelper(
                                  text: 'Simpan Perubahan',
                                  fontSize: 15.sp,
                                )),
                          ),
                          SizedBox(height: 25.h),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 36.w),
                            height: 2.h,
                            width: double.infinity,
                            color: AppColors.textgrey,
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextHelper(
                                    text: 'Produk Usaha',
                                    fontSize: 15.sp,
                                    fontFamily: FontFamily.bold,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                TextButton(
                                  onPressed: () =>
                                      provider.toAddProduct(context),
                                  child: TextHelper(
                                    text: 'Tambah Produk',
                                    fontSize: 15.sp,
                                    fontFamily: FontFamily.bold,
                                    fontColor: AppColors.secondary,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 3.w),

                          // SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: provider.getProduk(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SliverToBoxAdapter(
                              child: Shimmer.fromColors(
                                baseColor: AppColors.inputgrey,
                                highlightColor: AppColors.textgrey,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: AppColors.textgrey,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 4.w),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.w, vertical: 5.h),
                                        child: Image.asset(
                                          'assets/images/sate.png',
                                          width: 100.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ShimmerLine(
                                                height: 22.sp,
                                                width: 70.w,
                                              ),
                                              SizedBox(height: 2.h),
                                              ShimmerLine(
                                                height: 15.sp,
                                                width: 80.w,
                                              ),
                                              SizedBox(height: 2.h),
                                              ShimmerLine(
                                                height: 16.sp,
                                                width: 120.w,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 8.w, bottom: 3.h),
                                            child: ShimmerLine(
                                                height: 16.sp, width: 16.sp),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 8.w, top: 3.h),
                                            child: ShimmerLine(
                                                height: 16.sp, width: 16.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (snapshot.data!.length == 0) {
                            return SliverToBoxAdapter(
                              child: Container(
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    Image.asset(
                                      'assets/images/empty_product.png',
                                      width: 90.w,
                                      height: 90.h,
                                    ),
                                    SizedBox(height: 8.h),
                                    TextHelper(
                                        text: "Belum Ada Produk",
                                        fontSize: 16.sp),
                                    SizedBox(height: 40.h),
                                  ],
                                ),
                              ),
                            );
                          }
                          return SliverList(
                              // itemCount: snapshot.data!.length,
                              delegate: SliverChildBuilderDelegate(
                            childCount: snapshot.data!.length,
                            (context, index) {
                              final itemData = snapshot.data![index];
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: AppColors.textgrey,
                                    width: 2.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 4.w),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: Image.network(
                                          ApiUtil.urlBase +
                                              'storage/' +
                                              itemData!.produk_gambar!,
                                          width: 100.w,
                                          height: 100.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            itemData.produk_rating != null
                                                ? RatingBarIndicator(
                                                    rating: itemData
                                                        .produk_rating!, // Rating yang ingin ditampilkan
                                                    itemPadding:
                                                        EdgeInsets.zero,
                                                    itemCount:
                                                        5, // Jumlah bintang yang ingin ditampilkan
                                                    itemSize:
                                                        16.sp, // Ukuran bintang
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                  )
                                                : TextHelper(
                                                    text: 'Belum ada penilaian',
                                                    fontSize: 13.sp,
                                                    fontColor:
                                                        AppColors.textgrey,
                                                    fontFamily:
                                                        FontFamily.regular,
                                                  ),
                                            TextHelper(
                                              text: itemData.produk_nama,
                                              fontSize: 15.sp,
                                              fontFamily: FontFamily.bold,
                                            ),
                                            TextHelper(
                                              text: provider.toMoney(
                                                  itemData.produk_harga!),
                                              fontSize: 15.sp,
                                              fontFamily: FontFamily.bold,
                                              fontColor: AppColors.secondary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () =>
                                              provider.toEditProduct(
                                                  context,
                                                  itemData.produk_id.toString(),
                                                  itemData.produk_gambar
                                                      .toString(),
                                                  itemData.produk_nama
                                                      .toString(),
                                                  itemData.produk_harga
                                                      .toString()),
                                          icon: Icon(Icons.edit),
                                          color: AppColors.black,
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              provider.deleteProduct(
                                                  context,
                                                  itemData!.produk_id
                                                      .toString()),
                                          icon: Icon(Icons.delete),
                                          color: AppColors.textgrey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ));
                        }),
                    SliverPadding(padding: EdgeInsets.only(bottom: 40.h)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
