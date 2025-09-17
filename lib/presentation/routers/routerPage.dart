import 'package:app_real_estate/presentation/routers/routerName.dart';
import 'package:app_real_estate/presentation/views/screens/main/main_binding.dart';
import 'package:app_real_estate/presentation/views/screens/my_article/my_article_binding.dart';
import 'package:app_real_estate/presentation/views/screens/my_favourite/MyFavouriteScreen.dart';
import 'package:app_real_estate/presentation/views/screens/my_favourite/my_favourite_binding.dart';
import 'package:get/get.dart';

import '../views/screens/detail/DetailScreen.dart';
import '../views/screens/detail/detail_binding.dart';
import '../views/screens/filter/filter_binding.dart';
import '../views/screens/filter/filter_screen.dart';
import '../views/screens/main/MainScreen.dart';
import '../views/screens/my_article/MyArticleScreen.dart';
import '../views/screens/NotFoundScreen.dart';
import '../views/screens/RealEstatePostScreen.dart';
import '../views/screens/SearchScreen.dart';
import '../views/screens/login/LoginScreen.dart';
import '../views/screens/login/binding.dart';
import '../views/screens/splash/splash_screen.dart';

var pages = [
  GetPage(name: RouterName.notfound, page: () => NotFoundScreen()),
  GetPage(name: RouterName.splash, page: () => const SplashScreen()),
  GetPage(
    name: RouterName.login,
    page: () => LoginScreen(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: RouterName.main,
    page: () => MainScreen(),
    binding: MainBinding(),
  ),
  GetPage(
    name: RouterName.detail,
    page: () => DetailScreen(),
    binding: DetailBinding(),
  ),
  GetPage(
    name: RouterName.search,
    page: () => SearchScreen(),
    transition: Transition.upToDown,
    fullscreenDialog: true,
    opaque: false,
  ),
  GetPage(
    name: RouterName.filter,
    page: () => FilterScreen(),
    transition: Transition.upToDown,
    fullscreenDialog: true,
    binding: FilterBinding(),
  ),
  GetPage(
    name: RouterName.myArticle,
    page: () => MyArticleScreen(),
    binding: MyArticleBinding(),
  ),
  GetPage(
    name: RouterName.myFavourite,
    page: () => MyFavoutiteScreen(),
    binding: MyFavouriteBinding(),
  ),
  GetPage(name: RouterName.post, page: () => RealEstateFormScreen()),
];
