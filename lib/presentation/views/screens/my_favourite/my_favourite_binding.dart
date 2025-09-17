import 'package:app_real_estate/data/datasources/remote/listing_favourite_remote_data_source.dart';
import 'package:app_real_estate/data/repositories/listing_favourite_repository_impl.dart';
import 'package:app_real_estate/domain/repositories/listing_favourite_repository.dart';
import 'package:app_real_estate/domain/usecases/get_listing_favourite_use_case.dart';
import 'package:app_real_estate/presentation/views/screens/my_favourite/my_favourite_controller.dart';
import 'package:get/get.dart';

class MyFavouriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListingFavouriteRemoteDataSource>(
      () => ListingFavouriteRemoteDataSourceImpl(),
    );
    Get.lazyPut<ListingFavouriteRepository>(
      () => ListingFavouriteRepositoryImpl(Get.find()),
    );

    Get.lazyPut(() => GetListingFavouriteUseCase(Get.find()));

    Get.lazyPut(() => MyFavouriteController(Get.find()));
  }
}
