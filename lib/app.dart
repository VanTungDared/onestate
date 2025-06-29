import 'package:app_real_estate/presentation/routers/routerPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/utils/app_translation.dart';
import 'presentation/routers/routerName.dart';
import 'presentation/views/app/app_bindings.dart';
import 'presentation/views/screens/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme:
                GoogleFonts.robotoCondensedTextTheme(), // Sử dụng font Poppins
          ),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.light,
          initialRoute: RouterName.splash,
          initialBinding: AppBinding(),
          getPages: pages,
          unknownRoute: pages[0],
          translations: AppTranslations(),
          locale: const Locale('vi', 'VN'),
          fallbackLocale: const Locale('en', 'US'),
          supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
