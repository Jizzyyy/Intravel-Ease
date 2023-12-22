import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intravel_ease/configs/api_util.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/models/model_shared_preferences/agenda_model.dart';
import 'package:intravel_ease/providers/detail_place_provider.dart';
import 'package:intravel_ease/public_providers/public_two_provider%20.dart';
import 'package:intravel_ease/widgets/null_shimmer.dart';
import 'package:intravel_ease/widgets/shimmer_detail.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DetailPlaceScreen extends StatefulWidget {
  const DetailPlaceScreen({Key? key}) : super(key: key);

  @override
  State<DetailPlaceScreen> createState() => _DetailPlaceScreenState();
}

class _DetailPlaceScreenState extends State<DetailPlaceScreen> {
  //
  DetailPlaceProvider initProvider = DetailPlaceProvider();

  AgendaModel? modelAgenda;
  void addListItinerary(BuildContext context) async {
    final test = Provider.of<PublicTwoProvider>(context, listen: false);
    AgendaModel agendaModel = AgendaModel(
      // id:modelAgenda?.id.toString(),
      id: test.one,
      kategori: '1',
      namaWisata: test.two,
      deskripsi: modelAgenda?.deskripsi,
      tanggal: modelAgenda?.tanggal,
      jamMulai: modelAgenda?.jamMulai,
      jamSelesai: modelAgenda?.jamSelesai,
      warna: modelAgenda?.warna,
    );
    AgendaModel.saveItinerary(agendaModel);
    // if (scaffoldKey.currentContext != null) {
    //   MessagesSnacbar.success(context, 'Berhasil Menambahkan List Andaaa');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: initProvider,
      child: Consumer<DetailPlaceProvider>(builder: (context, provider, child) {
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
                            // addListItinerary(context);
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
                future: provider.getWisataDetail(context),
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
                              // color: AppColors.textgrey,
                            ),
                          ),
                          TextHelper(
                            text: '${snapshot.data!.wisata_nama}',
                            fontSize: 15.sp,
                            // fontColor: AppColors.textgrey,
                          ),
                        ]),
                        flexibleSpace: FlexibleSpaceBar(
                          background: CarouselSlider.builder(
                            itemCount: snapshot.data!.image!.length,
                            itemBuilder: (context, index, realIndex) {
                              return Image.network(
                                ApiUtil.urlBase +
                                    'storage/' +
                                    snapshot.data!.image![index]
                                        .gambar_wisata_gambar!,
                                fit: BoxFit.cover,
                              );
                            },
                            options: CarouselOptions(
                              height: double.infinity,
                              autoPlay: true,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                            ),
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
                                  child: snapshot.data!.wisata_rating != null
                                      ? RatingBarIndicator(
                                          rating: snapshot.data!.wisata_rating!,
                                          itemCount: 5,
                                          itemSize: 22.sp,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          // onRatingUpdate: (rating) {
                                          //   (rating);
                                          // },
                                        )
                                      : TextHelper(
                                          text: 'Belum ada penilaian',
                                          fontSize: 18.sp)),
                              Container(
                                padding: EdgeInsets.only(top: 6.h, left: 18.w),
                                child: TextHelper(
                                    text: snapshot.data!.wisata_nama,
                                    fontSize: 26.sp),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 18.w),
                                child: TextHelper(
                                  text:
                                      "${snapshot.data!.wisata_kota}, ${snapshot.data!.wisata_provinsi}",
                                  fontSize: 14.sp,
                                  fontColor: Colors.grey,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 5.h, left: 18.w),
                                    child: Image.asset(
                                      "assets/images/tiket.png",
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 5.h, left: 10.w),
                                    child: TextHelper(
                                      text: snapshot.data!.wisata_tiket ??
                                          'Tidak Ditemukan',
                                      fontSize: 14.sp,
                                      fontColor: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 18.w),
                                    child: Image.asset(
                                      "assets/images/hp.png",
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: TextHelper(
                                      text: snapshot.data!.wisata_kontak ??
                                          'Tidak ditemukan',
                                      fontSize: 14.sp,
                                      fontColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
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
                                            snapshot.data!.wisata_latitude!,
                                            snapshot.data!.wisata_longitude!),
                                        zoom: 13.0,
                                      ),
                                      markers: Set<Marker>.from([
                                        Marker(
                                          markerId: MarkerId('marker1'),
                                          position: LatLng(
                                              snapshot.data!.wisata_latitude!,
                                              snapshot.data!.wisata_longitude!),
                                          infoWindow: InfoWindow(
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
                                    text: "${snapshot.data!.wisata_deskripsi}",
                                    fontSize: 15.sp),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => provider.toNearestSpot(
                                          context,
                                          snapshot.data!.wisata_latitude
                                              .toString(),
                                          snapshot.data!.wisata_longitude
                                              .toString()),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: TextHelper(
                                          text: 'Wisata\nDisekitarnya',
                                          fontSize: 13.sp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => provider.toNearestUsaha(
                                          context,
                                          snapshot.data!.wisata_latitude
                                              .toString(),
                                          snapshot.data!.wisata_longitude
                                              .toString()),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                AppColors.secondary),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(4.sp),
                                        child: TextHelper(
                                            text: 'Produk\nDisekitarnya',
                                            textAlign: TextAlign.center,
                                            fontSize: 13.sp),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                                    child: snapshot.data!.wisata_rating != null
                                        ? RatingBarIndicator(
                                            rating:
                                                snapshot.data!.wisata_rating!,
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
                                                .data![index].ratingws_rating!,
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
                                                    fontSize: 13.sp))
                                            : Image.network(ApiUtil.urlBase +
                                                'storage/' +
                                                snapshotku.data![index].user!
                                                    .user_foto!),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10.w, right: 18.w),
                                          child: TextHelper(
                                              text:
                                                  "${snapshotku.data![index].ratingws_komentar}",
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
                                        initialRating: provider.myRating,
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
                                      text: provider.checkRating
                                          ? 'Edit'
                                          : 'Kirim',
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w800,
                                      fontColor: const Color.fromARGB(
                                          255, 63, 187, 192),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40.h),
                              // IconButton(
                              //     onPressed: () {
                              //       clearSharedPreferences();
                              //     },
                              //     icon: Icon(Icons.clear))
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
