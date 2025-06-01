import 'package:app_real_estate/routers/routerName.dart';
import 'package:app_real_estate/views/screens/DetailScreen.dart';
import 'package:app_real_estate/views/screens/LoginScreen.dart';
import 'package:app_real_estate/views/screens/MainScreen.dart';
import 'package:app_real_estate/views/screens/NotFoundScreen.dart';
import 'package:app_real_estate/views/screens/SearchScreen.dart';
import 'package:get/get.dart';

var pages = [
  GetPage(name: RouterName.notfound, page: () => NotFoundScreen()),
  GetPage(name: RouterName.login, page: () => LoginScreen()),
  GetPage(name: RouterName.main, page: () => MainScreen()),
  GetPage(name: RouterName.detail, page: () => DetailScreen()),
  GetPage(
    name: RouterName.search,
    page: () => SearchScreen(),
    transition: Transition.upToDown, // hoặc Transition.zoom, fade, ...
    fullscreenDialog: true,
    opaque: false,
  ),
];
