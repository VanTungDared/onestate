import 'package:get/get.dart';

import '../../../../data/datasources/remote/listing_remote_data_source.dart';
import '../../../../data/datasources/remote/user_remote_data_source.dart';
import '../../../../data/repositories/listing_repository_impl.dart';
import '../../../../data/repositories/user_repository_impl.dart';
import '../../../../domain/repositories/listing_repository.dart';
import '../../../../domain/repositories/user_repository.dart';
import '../../../../domain/usecases/filter_apartment_use_case.dart';
import '../../../../domain/usecases/get_listing_use_case.dart';
import '../../../../domain/usecases/get_user_usecase.dart';
import 'main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListingRemoteDataSource>(() => ListingRemoteDataSourceImpl());
    Get.lazyPut<ListingRepository>(() => ListingRepositoryImpl(Get.find()));

    Get.lazyPut<UserRemoteDataSource>(() => UserRemoteDataSourceImpl());
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()));

    Get.lazyPut(() => GetListingUseCase(Get.find()));
    Get.lazyPut(() => GetUserUseCase(Get.find()));
    Get.lazyPut(() => FilterApartmentUseCase(Get.find()));

    Get.lazyPut(() => MainController(Get.find(), Get.find(), Get.find()));
  }
}
