import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intravel_ease/configs/api_util.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/providers/home_provider.dart';
import 'package:intravel_ease/widgets/box_culinary.dart';
import 'package:intravel_ease/widgets/box_spot.dart';
import 'package:intravel_ease/widgets/null_shimmer.dart';
import 'package:intravel_ease/widgets/search_btn.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider initProvider = HomeProvider();

  @override
  void initState() {
    super.initState();
    initProvider.getUser();
    setState(() {
      initProvider.getLocation(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: initProvider,
      child: Consumer<HomeProvider>(builder: (context, provider, child) {
        return Scaffold(
          key: provider.scaffoldKey,
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                          height: MediaQuery.of(context).padding.top + 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextHelper(
                                  text: 'Hai, ${provider.user_nama}',
                                  fontSize: 35.sp,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  fontFamily: FontFamily.semibold,
                                ),
                                TextHelper(
                                  text: 'Temukan destinasi wisata favoritmu',
                                  fontSize: 14.sp,
                                  fontFamily: FontFamily.semibold,
                                  fontColor: AppColors.textgrey,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      //?end name
                      SizedBox(height: 16.h),
                      //!start btn-search
                      SearchButton(
                          haveContent: false,
                          onClick: () => provider.toSearch(context),
                          text: 'Cari Tempat Liburanmu'),
                      // //?end btn-search
                      SizedBox(height: 12.h),
                      //!start Lihat Semua kuliner
                      //?end Lihat Semua kuliner
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 0),
                sliver: SliverToBoxAdapter(
                  child: //!start Lihat Semua `wisata`
                      Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextHelper(
                        text: 'Wisata Terdekat',
                        fontSize: 18.sp,
                        fontFamily: FontFamily.bold,
                        fontColor: AppColors.black,
                      ),
                      TextButton(
                        onPressed: () => provider.toNearestSpot(context),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.zero),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: TextHelper(
                          text: 'Lihat Semua',
                          fontSize: 14.sp,
                          fontFamily: FontFamily.bold,
                          fontColor: AppColors.secondary,
                        ),
                      )
                    ],
                  ),
                  //?end Lihat Semua wisata,
                ),
              ),
              //!start wisata
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder(
                      future: provider.checkLocation!
                          ? provider.getWisata(context)
                          : Future.value([]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Row(
                            children: List.generate(5, (index) {
                              return const NullShimmer();
                            }),
                          );
                        } else if (snapshot.data!.isEmpty) {
                          return Container(
                            color: AppColors.inputgrey,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 16.h),
                                  Image.asset(
                                      'assets/images/empty_location.png',
                                      height: 70.h),
                                  SizedBox(height: 10.h),
                                  TextHelper(
                                    text: 'Wisata Tidak Ditemukan',
                                    fontSize: 16.sp,
                                    fontColor: AppColors.textgrey,
                                  ),
                                  SizedBox(height: 16.h),
                                ],
                              ),
                            ),
                          );
                        }
                        return Row(
                          children:
                              List.generate(snapshot.data!.length, (index) {
                            return BoxSpot(
                              image: ApiUtil.urlBase +
                                  'storage/' +
                                  snapshot
                                      .data![index]!.image!.gambar_wisata_gambar
                                      .toString(),
                              topText:
                                  snapshot.data![index]!.wisata_nama.toString(),
                              distance:
                                  snapshot.data![index]!.distance.toString(),
                              midleText: snapshot.data![index]!.wisata_kota
                                      .toString() +
                                  ', ' +
                                  snapshot.data![index]!.wisata_provinsi
                                      .toString(),
                              onClick: () => provider.toDetailWisata(context,
                                  snapshot.data![index]!.wisata_id.toString()),
                            );
                          }),
                        );
                      }),
                ),
              ),
              //?end wisata
              SliverPadding(
                padding: EdgeInsets.fromLTRB(12.w, 22.h, 12.w, 0),
                sliver: SliverToBoxAdapter(
                  child: //!start Lihat Semua usaha
                      Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextHelper(
                        text: 'Kuliner & Produk Terdekat',
                        fontSize: 18.sp,
                        fontFamily: FontFamily.bold,
                        fontColor: AppColors.black,
                      ),
                      TextButton(
                        onPressed: () => provider.toNearestUsaha(context),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.zero),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: TextHelper(
                          text: 'Lihat Semua',
                          fontSize: 14.sp,
                          fontFamily: FontFamily.bold,
                          fontColor: AppColors.secondary,
                        ),
                      )
                    ],
                  ),
                  //?end Lihat Semua wisata,
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder(
                      future: provider.checkLocation!
                          ? provider.getProduk(context)
                          : Future.value([]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Row(
                            children: List.generate(10, (index) {
                              return const NullShimmer();
                            }),
                          );
                        } else if (snapshot.data!.isEmpty) {
                          return Container(
                            color: AppColors.inputgrey,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 16.h),
                                  Image.asset(
                                      'assets/images/empty_location.png',
                                      height: 70.h),
                                  SizedBox(height: 10.h),
                                  TextHelper(
                                    text: 'Usaha Tidak Ditemukan',
                                    fontSize: 16.sp,
                                    fontColor: AppColors.textgrey,
                                  ),
                                  SizedBox(height: 16.h),
                                ],
                              ),
                            ),
                          );
                        }
                        return Row(
                          children: List.generate(
                            snapshot.data!.length,
                            (index) {
                              return BoxCulinary(
                                image: ApiUtil.urlBase +
                                    'storage/' +
                                    snapshot.data![index]!.produk_gambar
                                        .toString(),
                                topText: snapshot.data![index]!.produk_nama
                                    .toString(),
                                midleText: snapshot.data![index]!.produk_rating
                                    .toString(),
                                onClick: () => provider.toDetailProduk(
                                    context,
                                    snapshot.data![index]!.produk_id
                                        .toString()),
                                bottomText: provider.toMoney(
                                    snapshot.data![index].produk_harga),
                                icon: Icons.star,
                                distance:
                                    snapshot.data![index]!.distance.toString(),
                              );
                            },
                          ),
                        );
                      }),
                ),
              ),
              //? end lihat usaha
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 12.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextHelper(
                              text: 'Lokasi Saya',
                              fontSize: 18.sp,
                              fontFamily: FontFamily.bold,
                              fontColor: AppColors.black,
                            ),
                            TextButton(
                              onPressed: () => provider.getLocation(context),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                                visualDensity: VisualDensity.compact,
                              ),
                              child: TextHelper(
                                text: 'Dapatkan Lokasi Saya',
                                fontSize: 15.sp,
                                fontFamily: FontFamily.bold,
                                fontColor: AppColors.secondary,
                              ),
                            )
                          ],
                        ),
                        //todo maps
                        SizedBox(height: 5.h),
                        Center(
                          child: Container(
                            height: 300.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r))),
                            child: GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: provider.kcameraposition,
                              markers: provider.markers,
                              onMapCreated: (GoogleMapController controller) {
                                provider.googleMapController = controller;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

double calculateItemHeight(String content) {
  final textSpan = TextSpan(
    text: content,
    style: TextStyle(fontSize: 20.0),
  );

  final textPainter = TextPainter(
    text: textSpan,
    maxLines: 1,
    textDirection: TextDirection.ltr,
  );

  textPainter.layout();

  return textPainter.height +
      32.0; // Tinggi teks ditambahkan dengan padding (misalnya 32.0) untuk mendapatkan tinggi item secara keseluruhan.
}
