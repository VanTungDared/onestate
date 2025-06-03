import 'package:app_real_estate/routers/routerName.dart';
import 'package:app_real_estate/views/screens/DetailScreen.dart';
import 'package:app_real_estate/views/screens/LoginScreen.dart';
import 'package:app_real_estate/views/screens/MainScreen.dart';
import 'package:app_real_estate/views/screens/MyArticleScreen.dart';
import 'package:app_real_estate/views/screens/MyLikedScreen.dart';
import 'package:app_real_estate/views/screens/NotFoundScreen.dart';
import 'package:app_real_estate/views/screens/RealEstatePostScreen.dart';
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
  GetPage(name: RouterName.myArticle, page: () => MyArticleScreen()),
  GetPage(name: RouterName.myLike, page: () => MyLikedScreen()),
  GetPage(name: RouterName.post, page: () => RealEstateFormScreen()),
];
