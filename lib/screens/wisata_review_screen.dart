import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/providers/wisata_review_provider.dart';
import 'package:intravel_ease/widgets/null_shimmer.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../configs/api_util.dart';

class WisataReviewScreen extends StatefulWidget {
  const WisataReviewScreen({super.key});

  @override
  State<WisataReviewScreen> createState() => _WisataReviewScreenState();
}

class _WisataReviewScreenState extends State<WisataReviewScreen> {
  WisataReviewProvider initProvider = WisataReviewProvider();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: initProvider,
      child: Consumer<WisataReviewProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      TextHelper(text: 'Rating Wisata', fontSize: 18.sp)
                    ],
                  ),
                ),
                SliverPadding(padding: EdgeInsets.only(top: 10.h)),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      provider.buttonRadio(0, 'Semua', context),
                      provider.buttonRadio(5, '5', context),
                      provider.buttonRadio(4, '4', context),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      provider.buttonRadio(3, '3', context),
                      provider.buttonRadio(2, '2', context),
                      provider.buttonRadio(1, '1', context),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Container(height: 3.h, color: AppColors.textgrey),
                  ),
                ),
                FutureBuilder(
                  future: provider.getFilter(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SliverToBoxAdapter(
                        child: Shimmer.fromColors(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 20.h),
                              child: Column(
                                children: List.generate(20, (index) {
                                  return Column(
                                    children: [
                                      ShimmerLine(height: 50.h),
                                      SizedBox(height: 4.h),
                                    ],
                                  );
                                }),
                              ),
                            ),
                            baseColor: AppColors.inputgrey,
                            highlightColor: AppColors.textgrey),
                      );
                    }
                    if (!snapshot.hasData) {
                      return SliverToBoxAdapter(
                        child: Center(
                            child: Column(
                          children: [
                            SizedBox(height: 80.h),
                            Image.asset('assets/images/empty_product.png',
                                height: 120.h, width: 120.w),
                            SizedBox(height: 10.h),
                            TextHelper(
                                text: 'Ulasan Tidak Ditemukan', fontSize: 15.sp)
                          ],
                        )),
                      );
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: snapshot.data!.length,
                        (context, index) => Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 15.h, left: 12.w),
                                    child: TextHelper(
                                        text:
                                            "${snapshot.data![index].user!.user_nama}",
                                        fontSize: 14.sp),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 15.h, left: 12.w, right: 12.w),
                                    child: RatingBarIndicator(
                                      itemCount: 5,
                                      rating: snapshot
                                          .data![index].ratingws_rating!,
                                      itemSize: 14.0,
                                      itemBuilder: (context, _) => const Icon(
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
                                  child: snapshot
                                              .data![index].user!.user_foto ==
                                          null
                                      ? CircleAvatar(
                                          child: TextHelper(
                                              text:
                                                  '${snapshot.data![index].user!.user_nama.toString().substring(0, 2)}',
                                              fontSize: 13.sp))
                                      : Image.network(ApiUtil.urlBase +
                                          'storage/' +
                                          snapshot
                                              .data![index].user!.user_foto!),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 18.w),
                                    child: TextHelper(
                                        text:
                                            "${snapshot.data![index].ratingws_komentar}",
                                        fontSize: 12.sp),
                                  ),
                                ),
                              ]),
                              Container(
                                height: 1.h,
                                color: AppColors.textgrey,
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
