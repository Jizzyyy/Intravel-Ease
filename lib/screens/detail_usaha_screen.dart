import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intravel_ease/configs/api_util.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/providers/detail_usaha_provider.dart';
import 'package:intravel_ease/widgets/null_shimmer.dart';
import 'package:intravel_ease/widgets/shimmer_detail.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DetailUsahaScreen extends StatefulWidget {
  const DetailUsahaScreen({Key? key}) : super(key: key);

  @override
  State<DetailUsahaScreen> createState() => _DetailUsahaScreenState();
}

class _DetailUsahaScreenState extends State<DetailUsahaScreen> {
  @override
  Widget build(BuildContext context) {
    DetailUsahaProvider initProvider = DetailUsahaProvider();

    return ChangeNotifierProvider.value(
      value: initProvider,
      child: Consumer<DetailUsahaProvider>(builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            EasyLoading.dismiss();
            return true;
          },
          child: Scaffold(
            key: provider.scaffoldKey,
            bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                height: 75.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              provider.showBottomSheet(context);
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color.fromARGB(255, 63, 187,
                                    197); // Color for when the button is pressed
                              } else {
                                // Color for when the button is disabled
                              }
                              return Colors.white; // Default color
                            }),
                          ),
                          child: TextHelper(
                              fontColor: Colors.black,
                              text: "Tambah Ke Jadwal",
                              fontSize: 15.sp)),
                      IconButton(
                        iconSize: 32,
                        icon: const Icon(Icons.favorite,
                            color: Color.fromARGB(255, 63, 187, 197)),
                        onPressed: () => provider.addFavorite(context),
                      ),
                    ],
                  ),
                )),

            // body
            body: FutureBuilder(
                future: provider.getProdukDetail(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ShimmerDetail();
                  }
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 250.h,
                        backgroundColor: AppColors.black,
                        floating: true,
                        pinned: true,
                        snap: false,
                        automaticallyImplyLeading: false,
                        title: Row(children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                            ),
                          ),
                          TextHelper(
                            text: '${snapshot.data!.produk_nama.toString()}',
                            fontSize: 15.sp,
                          ),
                        ]),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Image.network(
                            ApiUtil.urlBase +
                                'storage/' +
                                snapshot.data!.produk_gambar!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Form(
                          key: provider.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding:
                                      EdgeInsets.only(top: 15.h, left: 18.w),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: snapshot.data!.produk_rating != null
                                      ? RatingBarIndicator(
                                          rating: snapshot.data!.produk_rating!,
                                          itemCount: 5,
                                          itemSize: 22.sp,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                        )
                                      : TextHelper(
                                          text: 'Belum ada penilaian',
                                          fontSize: 18.sp)),
                              Container(
                                padding: EdgeInsets.only(top: 1.h, left: 18.w),
                                child: TextHelper(
                                    text: snapshot.data!.produk_nama,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    fontFamily: FontFamily.bold,
                                    fontSize: 20.sp),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 18.w),
                                child: TextHelper(
                                    text: provider
                                        .toMoney(snapshot.data!.produk_harga!),
                                    fontColor: AppColors.secondary,
                                    fontSize: 22.sp),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 18.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          child: Image.network(ApiUtil.urlBase +
                                              'storage/' +
                                              snapshot
                                                  .data!.usaha!.usaha_gambar!),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            TextHelper(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              text: snapshot
                                                  .data?.usaha?.usaha_nama,
                                              fontSize: 16.sp,
                                              fontFamily: FontFamily.bold,
                                            ),
                                            SizedBox(height: 3.h),
                                            TextHelper(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              fontColor: AppColors.textgrey,
                                              text:
                                                  '${snapshot.data?.usaha?.usaha_kota}, ${snapshot.data!.usaha!.usaha_provinsi}',
                                              fontSize: 14.sp,
                                              fontFamily: FontFamily.bold,
                                            ),
                                            SizedBox(height: 3.h),
                                            Row(
                                              children: [
                                                const Icon(Icons.phone_android,
                                                    color: AppColors.textgrey),
                                                TextHelper(
                                                    text: snapshot.data!.usaha!
                                                        .usaha_kontak,
                                                    fontSize: 13.sp),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Center(
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  height: 140.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: GoogleMap(
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            snapshot
                                                .data!.usaha!.usaha_latitude!,
                                            snapshot
                                                .data!.usaha!.usaha_longitude!),
                                        zoom: 13.0,
                                      ),
                                      markers: Set<Marker>.from([
                                        Marker(
                                          markerId: const MarkerId('marker1'),
                                          position: LatLng(
                                              snapshot
                                                  .data!.usaha!.usaha_latitude!,
                                              snapshot.data!.usaha!
                                                  .usaha_longitude!),
                                          infoWindow: const InfoWindow(
                                              title: 'Marker 1',
                                              snippet: 'Deskripsi Marker 1'),
                                        ),
                                      ]),
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        provider.mapController = controller;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Container(
                                padding: EdgeInsets.only(top: 5.h, left: 18.w),
                                child: TextHelper(
                                    text: "Deskripsi", fontSize: 23.sp),
                              ),
                              SizedBox(height: 6.h),
                              Container(
                                padding:
                                    EdgeInsets.only(left: 18.w, right: 18.w),
                                child: TextHelper(
                                    text:
                                        "${snapshot.data!.usaha!.usaha_deskripsi}",
                                    fontSize: 15.sp),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                padding: EdgeInsets.only(top: 16.h, left: 18.w),
                                child: TextHelper(
                                    text: "Penilaian", fontSize: 23.sp),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 18.w),
                                    child: snapshot.data!.produk_rating != null
                                        ? RatingBarIndicator(
                                            rating:
                                                snapshot.data!.produk_rating!,
                                            itemCount: 5,
                                            itemSize: 16.0,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                          )
                                        : TextHelper(
                                            text: 'Belum ada penilaian',
                                            fontSize: 14.sp),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 18.w),
                                    child: TextButton(
                                      onPressed: () =>
                                          provider.toAllReview(context),
                                      child: TextHelper(
                                        text: "Lihat Semua",
                                        fontSize: 14.sp,
                                        fontColor: AppColors.secondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(height: 1.h, color: AppColors.textgrey),
                            ],
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: provider.getPaginate(context),
                        builder: (context, snapshotku) {
                          if (snapshotku.connectionState ==
                              ConnectionState.waiting) {
                            print('ini snapshotku : $snapshotku');
                            return SliverToBoxAdapter(
                                child: Shimmer.fromColors(
                                    child: Column(children: [
                                      ShimmerLine(height: 20.h),
                                      ShimmerLine(height: 20.h),
                                      ShimmerLine(height: 20.h),
                                      ShimmerLine(height: 20.h),
                                    ]),
                                    baseColor: AppColors.inputgrey,
                                    highlightColor: AppColors.textgrey));
                          }
                          if (!snapshotku.hasData) {
                            return SliverToBoxAdapter(child: Container());
                          }
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: snapshotku.data!.length,
                              (context, index) => Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 15.h, left: 12.w),
                                          child: TextHelper(
                                              text:
                                                  "${snapshotku.data![index].user!.user_nama}",
                                              fontSize: 14.sp),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 15.h,
                                              left: 12.w,
                                              right: 12.w),
                                          child: RatingBarIndicator(
                                            itemCount: 5,
                                            rating: snapshotku
                                                .data![index].ratingpd_rating!,
                                            itemSize: 14.0,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 12.w),
                                        width: 50.w,
                                        height: 50.h,
                                        child: snapshotku.data![index].user!
                                                    .user_foto ==
                                                null
                                            ? CircleAvatar(
                                                child: TextHelper(
                                                    text:
                                                        '${snapshotku.data![index].user!.user_nama.toString().substring(0, 2)}',
                                                    fontSize: 13.sp),
                                              )
                                            : Image.network(
                                                ApiUtil.urlBase +
                                                    'storage/' +
                                                    snapshotku.data![index]
                                                        .user!.user_foto!,
                                                // height: 50.h,
                                                // width: 50.w,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10.w, right: 18.w),
                                          child: TextHelper(
                                              text:
                                                  "${snapshotku.data![index].ratingpd_komentar}",
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.w, vertical: 10.h),
                          child: Column(
                            children: [
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/message.png",
                                    width: 35.w,
                                    height: 35.h,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Container(
                                      child: TextFormField(
                                        controller: provider.commentController,
                                        textAlign: TextAlign.start,
                                        maxLines: 3,
                                        cursorColor: Colors.grey,
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        decoration: InputDecoration(
                                          hintText: "Tambahkan Komentar",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      TextHelper(
                                          text: "Masukkan Rating :",
                                          fontSize: 15.sp),
                                      RatingBar.builder(
                                        initialRating: 0,
                                        itemCount: 5,
                                        minRating: 1,
                                        itemSize: 21.0,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          provider.ratingComment = rating;
                                        },
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        provider.addComment(context),
                                    child: TextHelper(
                                      text: "Kirim",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w800,
                                      fontColor: const Color.fromARGB(
                                          255, 63, 187, 192),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        );
      }),
    );
  }
}
