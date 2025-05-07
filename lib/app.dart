import 'package:app_real_estate/controllers/theme_controller.dart';
import 'package:app_real_estate/routers/routerPage.dart';
import 'package:app_real_estate/views/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // 🔹 Cấu hình theme sử dụng Google Fonts
      theme: ThemeData(
        textTheme:
            GoogleFonts.robotoCondensedTextTheme(), // Sử dụng font Poppins
      ),

      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,

      home: LoginScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(ThemeController());
      }),
      getPages: pages,
      unknownRoute: pages[0],

      // 🔹 Cấu hình localization
      locale: const Locale('vi'), // Mặc định là Tiếng Việt
      supportedLocales: const [
        Locale('en'), // English
        Locale('vi'), // Tiếng Việt
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
