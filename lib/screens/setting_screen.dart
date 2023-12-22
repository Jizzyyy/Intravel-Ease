import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/routes/circular_reveal_clipper.dart';
import 'package:intravel_ease/configs/api_util.dart';
import 'package:intravel_ease/providers/setting_provider.dart';
import 'package:intravel_ease/screens/change_password_screen.dart';
import 'package:intravel_ease/screens/display_account_screen.dart';
import 'package:intravel_ease/widgets/setting_list.dart';
import 'package:provider/provider.dart';

import '../configs/font_family.dart';
import '../widgets/text_helper.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingProvider initProvider = SettingProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initProvider.tampilData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: initProvider,
      child: Consumer<SettingProvider>(builder: (context, provider, child) {
        return Scaffold(
          body: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Column(children: [
                  SizedBox(height: MediaQuery.of(context).padding.top + 26.h),
                  TextHelper(
                    text: 'Profil',
                    fontSize: 20.sp,
                    fontFamily: FontFamily.bold,
                  ),
                  SizedBox(height: 46.h),
                  SizedBox(
                      width: 100.w,
                      height: 100.h,
                      child: provider.gambar == null
                          ? CircleAvatar(
                              child: TextHelper(
                                  text:
                                      provider.nama.toString().substring(0, 2),
                                  fontSize: 30.sp),
                            )
                          : ClipOval(
                              child: Image.network(
                                ApiUtil.urlBase +
                                    'storage/' +
                                    provider.gambar.toString(),
                                fit: BoxFit.cover,
                              ),
                            )),
                  SizedBox(height: 16.h),
                  TextHelper(
                    text: provider.nama ?? '',
                    fontSize: 20.sp,
                    fontFamily: FontFamily.bold,
                  ),
                  TextHelper(text: provider.email ?? '', fontSize: 15.sp),
                  SizedBox(height: 85.h),
                  SettingList(
                    text: 'Akun',
                    icon: Icons.person,
                    onClick: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DisplayAccount())),
                  ),
                  SettingList(
                    text: 'Kelola Usaha',
                    icon: Icons.store_mall_directory_sharp,
                    onClick: () => provider.buttonManange(context),
                  ),
                  SettingList(
                    text: 'Ubah Sandi',
                    icon: Icons.lock,
                    onClick: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChangePassword())),
                  ),
                  SettingList(
                    text: 'Keluar',
                    icon: Icons.logout,
                    // onClick: () async {
                    //   final prefs = await SharedPreferences.getInstance();
                    //   await prefs.clear();
                    // },
                    onClick: () => provider.buttonLogout(context),
                  ),
                ]),
              ),
            )
          ]),
        );
      }),
    );
  }
}
