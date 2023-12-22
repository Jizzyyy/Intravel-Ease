import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/api_util.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/models/model_shared_preferences/favorite_model.dart';
import 'package:intravel_ease/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

import '../configs/font_family.dart';
import '../widgets/text_helper.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WishlistProvider(),
      child: Consumer<WishlistProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: CustomScrollView(slivers: [
              SliverAppBar(
                title: TextHelper(
                  text: 'Favorit',
                  fontSize: 30.sp,
                  fontColor: AppColors.black,
                ),
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.white,
                centerTitle: true,
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 32.h),
              ),
              FutureBuilder(
                  future: FavoriteModel.getFavorites(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      print('masuk tidak ada data');
                      return SliverToBoxAdapter(
                        child: Text('kosong'),
                      );
                    }
                    if (snapshot.data!.length == 0) {
                      print('sudah 0');
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Container(
                            height: 200.h,
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/empty_product.png',
                                    height: 120.h,
                                    width: 120.w,
                                  ),
                                  SizedBox(height: 12.h),
                                  TextHelper(
                                    text: 'Kosong',
                                    fontSize: 19.sp,
                                    fontFamily: FontFamily.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return SliverToBoxAdapter(
                      child: Column(
                          children:
                              List.generate(snapshot.data!.length, (index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 32.h),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 6.h),
                                backgroundColor: AppColors.white),
                            onPressed: () => provider.toDetailWisata(
                                context,
                                snapshot.data![index].id,
                                snapshot.data![index].kategori),
                            child: Column(
                              children: [
                                Image.network(
                                  ApiUtil.urlBase +
                                      'storage/' +
                                      snapshot.data![index].gambar,
                                  width: double.infinity,
                                  height: 156.h,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 14.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // direction: Axis.vertical,
                                        children: [
                                          TextHelper(
                                            text: snapshot.data![index].nama,
                                            fontSize: 21.sp,
                                            fontColor: AppColors.black,
                                            fontFamily: FontFamily.bold,
                                          ),
                                          SizedBox(height: 12.h),
                                          TextHelper(
                                            text:
                                                '${snapshot.data![index].kota}, ${snapshot.data![index].provinsi}',
                                            fontSize: 11.sp,
                                            fontColor: AppColors.black,
                                          ),
                                          SizedBox(height: 14.h),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 30.w),
                                    Container(
                                      height: 36.h,
                                      width: 36.w,
                                      child: FloatingActionButton(
                                        backgroundColor: AppColors.black,
                                        onPressed: () {
                                          provider.removeFavorite(
                                              context, index);
                                        },
                                        child: const Icon(Icons.delete),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })),
                    );
                  })
            ]),
          );
        },
      ),
    );
  }
}
