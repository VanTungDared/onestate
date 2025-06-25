import 'package:app_real_estate/presentation/routers/routerName.dart';
import 'package:app_real_estate/presentation/views/screens/main/main_binding.dart';
import 'package:get/get.dart';

import '../views/screens/DetailScreen.dart';
import '../views/screens/main/MainScreen.dart';
import '../views/screens/MyArticleScreen.dart';
import '../views/screens/MyLikedScreen.dart';
import '../views/screens/NotFoundScreen.dart';
import '../views/screens/RealEstatePostScreen.dart';
import '../views/screens/SearchScreen.dart';
import '../views/screens/login/LoginScreen.dart';
import '../views/screens/login/binding.dart';

var pages = [
  GetPage(name: RouterName.notfound, page: () => NotFoundScreen()),
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
  GetPage(name: RouterName.detail, page: () => DetailScreen()),
  GetPage(
    name: RouterName.search,
    page: () => SearchScreen(),
    transition: Transition.upToDown,
    fullscreenDialog: true,
    opaque: false,
  ),
  GetPage(name: RouterName.myArticle, page: () => MyArticleScreen()),
  GetPage(name: RouterName.myLike, page: () => MyLikedScreen()),
  GetPage(name: RouterName.post, page: () => RealEstateFormScreen()),
];
