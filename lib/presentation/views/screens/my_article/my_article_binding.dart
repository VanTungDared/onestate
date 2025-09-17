import 'package:app_real_estate/data/datasources/remote/listing_me_remote_data_source.dart';
import 'package:app_real_estate/data/repositories/listing_me_repository_impl.dart';
import 'package:app_real_estate/domain/repositories/listing_me_repository.dart';
import 'package:app_real_estate/domain/usecases/get_listing_me_use_case.dart';
import 'package:app_real_estate/presentation/views/screens/my_article/my_article_controller.dart';
import 'package:get/get.dart';

class MyArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListingMeRemoteDataSource>(
      () => ListingMeRemoteDataSourceImpl(),
    );
    Get.lazyPut<ListingMeRepository>(() => ListingMeRepositoryImpl(Get.find()));

    Get.lazyPut(() => GetListingMeUseCase(Get.find()));

    Get.lazyPut(() => MyArticleController(Get.find()));
  }
}
