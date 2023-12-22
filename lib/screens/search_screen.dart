import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/providers/search_provider.dart';
import 'package:intravel_ease/screens/product.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';

import '../configs/app_color.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> filteredList = [];

  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    filteredList = produklist;
  }

  void filterProducts() {
    if (selectedCategories.isEmpty) {
      filteredList = List.from(produklist);
    } else {
      filteredList = produklist
          .where((product) => selectedCategories.contains(product.kategori))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: Consumer<SearchProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                //!start appbar
                SliverAppBar(
                  toolbarHeight: 70,
                  backgroundColor: AppColors.white,
                  automaticallyImplyLeading: false,
                  title: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).padding.top),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: provider.searchController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {
                                provider.buttonSearch(context, value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 6.w, vertical: 3),
                                filled: true,
                                fillColor: AppColors.inputgrey,
                                hintText: 'Cari Tempat Yang Di Inginkan',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.r),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: GestureDetector(
                                  child: const Icon(Icons.search),
                                  onTap: () {
                                    provider.buttonSearch(context,
                                        provider.searchController.text);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //?end appbar
                SliverPadding(
                  padding: EdgeInsets.only(top: 100.h, left: 12.w, right: 12.w),
                  sliver: FutureBuilder(
                      future: provider.historySearch(),
                      builder: (context, snapshot) {
                        return SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors
                                            .white), // Set background color here
                                    elevation: MaterialStateProperty.all(
                                        0), // Set elevation to 0
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero)),
                                onPressed: () {
                                  if (snapshot.data?[index].toString() !=
                                      'Lihat Semua Wisata') {
                                    provider.buttonSearch(context,
                                        '${snapshot.data?[index].toString()}');
                                  } else {
                                    provider.allTours(context, ' ');
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets
                                      .zero, // Menghilangkan padding di sisi bawah
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: AppColors
                                              .inputgrey, // Warna border di sisi bawah
                                          width:
                                              2.0, // Lebar border di sisi bawah
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: TextHelper(
                                        text:
                                            '${snapshot.data?[index].toString()}',
                                        fontSize: 15.sp,
                                        fontColor: AppColors.textgrey,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: snapshot.data?.length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 4 / 1,
                            crossAxisCount: 2,
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
