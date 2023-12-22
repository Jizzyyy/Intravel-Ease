import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intravel_ease/configs/btn_color.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/public_providers/public_add_bussiness_provider.dart';
import 'package:intravel_ease/public_providers/public_agenda_provider.dart';
import 'package:intravel_ease/public_providers/public_bussiness_provider.dart';
import 'package:intravel_ease/public_providers/public_distance_provider.dart';
import 'package:intravel_ease/public_providers/public_one_provider.dart';
import 'package:intravel_ease/public_providers/public_product_provider.dart';
import 'package:intravel_ease/public_providers/public_register_provider.dart';
import 'package:intravel_ease/public_providers/public_two_provider%20.dart';
import 'package:intravel_ease/screens/detail_schedule_screen.dart';
import 'package:intravel_ease/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'configs/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initializeDateFormatting('id_ID', null);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => PublicRegisterProvider()),
            ChangeNotifierProvider(create: (_) => PublicOneProvider()),
            ChangeNotifierProvider(create: (_) => PublicAddBussinessProvider()),
            ChangeNotifierProvider(create: (_) => PublicBussinessProvider()),
            ChangeNotifierProvider(create: (_) => PublicProductProvider()),
            ChangeNotifierProvider(create: (_) => PublicDistanceProvider()),
            ChangeNotifierProvider(create: (_) => PublicTwoProvider()),
            ChangeNotifierProvider(create: (_) => PublicAgendaProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            color: AppColors.white,
            theme: ThemeData(
              primarySwatch: Palette.pcolor,
              fontFamily: FontFamily.semibold,
              scaffoldBackgroundColor: AppColors.white,
            ),
            home: child,
            builder: EasyLoading.init(),
            initialRoute: '/',
            routes: {
              '/nextPage': (context) => const DetailSchedule(),
            },
          ),
        );
      },
      child: const SplashScreen(),
    );
  }
}
