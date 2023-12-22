import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/api_util.dart';
import 'package:intravel_ease/providers/result_search_provider.dart';
import 'package:intravel_ease/widgets/box_search.dart';
import 'package:intravel_ease/widgets/null_shimmer.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../configs/app_color.dart';
import '../widgets/search_btn.dart';

class ResultSearchScreen extends StatefulWidget {
  const ResultSearchScreen({Key? key}) : super(key: key);

  @override
  State<ResultSearchScreen> createState() => _ResultSearchScreenState();
}

class _ResultSearchScreenState extends State<ResultSearchScreen> {
  ResultSearchProvider initProvider = ResultSearchProvider();

  @override
  void initState() {
    super.initState();
    initProvider.publicOne(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: initProvider,
      child: Consumer<ResultSearchProvider>(
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
                            text: provider.dataSearch!),
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(
                      //     Icons.filter_alt_outlined,
                      //     color: AppColors.black,
                      //     size: 30.h,
                      //   ),
                      // ),
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
                            child: BoxSearch(
                                onClick: () => provider.toDetailWisata(
                                    context,
                                    snapshot.data![index]!.wisata_id
                                        .toString()),
                                image: ApiUtil.urlBase +
                                    'storage/' +
                                    snapshot.data![index]!.image!
                                        .gambar_wisata_gambar
                                        .toString(),
                                rating: snapshot.data?[index]?.wisata_rating,
                                topText: snapshot.data![index]!.wisata_nama
                                    .toString(),
                                midleText: snapshot.data![index]!.wisata_kota
                                        .toString() +
                                    ', ' +
                                    snapshot.data![index]!.wisata_provinsi
                                        .toString()),
                          ));
                }),
          );
        },
      ),
    );
  }
}
