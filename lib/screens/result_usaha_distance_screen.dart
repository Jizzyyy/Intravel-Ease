import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/api_util.dart';
import 'package:intravel_ease/providers/result_usaha_distance_provider.dart';
import 'package:intravel_ease/widgets/box_search_distance.dart';
import 'package:intravel_ease/widgets/null_shimmer.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../configs/app_color.dart';
import '../widgets/search_btn.dart';

class ResultUsahaDistanceScreen extends StatefulWidget {
  const ResultUsahaDistanceScreen({Key? key}) : super(key: key);

  @override
  State<ResultUsahaDistanceScreen> createState() =>
      _ResultUsahaDistanceScreenState();
}

class _ResultUsahaDistanceScreenState extends State<ResultUsahaDistanceScreen> {
  ResultUsahaDistanceProvider initProvider = ResultUsahaDistanceProvider();

  @override
  void initState() {
    super.initState();
    initProvider.publicOne(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: initProvider,
      child: Consumer<ResultUsahaDistanceProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            key: provider.scaffoldKey,
            backgroundColor: AppColors.white,
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          provider.bestRating(context);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: provider.selectedButton == 1
                                ? Colors.black
                                : Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            '#Rating Tertinggi',
                            style: TextStyle(
                              color: provider.selectedButton == 1
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          provider.mostReviews(context);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: provider.selectedButton == 2
                                ? Colors.black
                                : Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            '#Ulasan Terbanyak',
                            style: TextStyle(
                              color: provider.selectedButton == 2
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: AppColors.white,
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Wrap(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top + 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: SearchButton(
                            haveContent: true,
                            onClick: () => provider.toSearch(context),
                            text: 'Produk Disekitar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: FutureBuilder(
                future: provider.getWisata(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return MasonryGridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 0,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 4.h),
                            child: const NullShimmer(),
                          );
                        });
                  } else if (snapshot.data!.length == 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/location_not_found.png',
                                width: 100.w,
                                height: 100.h,
                              ),
                              SizedBox(height: 20.h),
                              TextHelper(
                                text: 'Wisata Tidak Ditemukan',
                                fontSize: 18.sp,
                                fontColor: AppColors.black,
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return MasonryGridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 0,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: BoxSearchDistance(
                        onClick: () => provider.toDetailWisata(context,
                            snapshot.data![index]!.produk_id.toString()),
                        image: ApiUtil.urlBase +
                            'storage/' +
                            snapshot.data![index]!.produk_gambar.toString(),
                        rating: snapshot.data?[index]?.produk_rating,
                        topText: snapshot.data![index]!.produk_nama.toString(),
                        midleText: 'test',
                        // midleText: provider
                        //     .toMoney(snapshot.data![index]!.produk_harga!),
                        distance: snapshot.data![index]!.distance.toString(),
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
