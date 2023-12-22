import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/screens/detail_schedule_screen.dart';
import 'package:intravel_ease/screens/home_screen.dart';
import 'package:intravel_ease/screens/setting_screen.dart';
import 'package:intravel_ease/screens/wishlist_screen.dart';

import '../configs/app_color.dart';
import '../widgets/text_helper.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeScreen(),
            // ScheduleScreen(),
            DetailSchedule(),
            WishlistScreen(),
            SettingScreen(),
          ]),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        child: BottomNavyBar(
          selectedIndex: _currentIndex,
          backgroundColor: AppColors.black,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.linear,
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
            // _pageController.animateToPage(index,
            // duration: Duration(milliseconds: 500),
            // curve: Curves.decelerate);
            _pageController.jumpToPage(index);
          }),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: const Icon(Icons.home),
                title: TextHelper(
                  text: 'Beranda',
                  fontSize: 14.sp,
                  fontFamily: FontFamily.regular,
                ),
                activeColor: AppColors.white,
                textAlign: TextAlign.center,
                inactiveColor: AppColors.inputgrey),
            BottomNavyBarItem(
              icon: Icon(Icons.calendar_month),
              title: TextHelper(
                text: 'Jadwal',
                fontSize: 14.sp,
                fontFamily: FontFamily.regular,
              ),
              activeColor: AppColors.inputgrey,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.favorite),
              title: TextHelper(
                text: 'Favorit',
                fontSize: 14.sp,
                fontFamily: FontFamily.regular,
              ),
              activeColor: AppColors.white,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: TextHelper(
                text: 'Pengaturan',
                fontSize: 14.sp,
                fontFamily: FontFamily.regular,
              ),
              activeColor: AppColors.white,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
