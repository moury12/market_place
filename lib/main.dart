import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:market_place/core/bindings/bindings.dart';
import 'package:market_place/core/routes/app_routes.dart';
import 'package:market_place/core/theme/app_theme.dart';
import 'package:market_place/presentations/navigation/views/navigation_page.dart';
import 'package:device_preview/device_preview.dart';
import 'core/utils/variable.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  // await Hive.initFlutter();
  // await Hive.openBox(userBoxName);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) =>const MyApp()));

  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 888),
      minTextAdapt: true,
      // useInheritedMediaQuery: true,
      builder: (context, child) => GetMaterialApp(
        title: 'Market Place',
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        initialRoute: NavigationPage.routeName,
        getPages: AppRoutes.route(),
        initialBinding: CommonBinding(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}