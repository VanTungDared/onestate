import 'package:get/get.dart';

import '../../../../data/datasources/remote/listing_remote_data_source.dart';
import '../../../../data/datasources/remote/provinces_remote_data_source.dart';
import '../../../../data/repositories/listing_repository_impl.dart';
import '../../../../data/repositories/provinces_repository_impl.dart';
import '../../../../domain/repositories/listing_repository.dart';
import '../../../../domain/repositories/provinces_repository.dart';
import '../../../../domain/usecases/filter_usecase.dart';
import '../../../../domain/usecases/get_district_use_case.dart';
import '../../../../domain/usecases/get_ward_use_case.dart';
import 'filter_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListingRemoteDataSource>(() => ListingRemoteDataSourceImpl());
    Get.lazyPut<ProvincesRemoteDataSource>(
      () => ProvincesRemoteDataSourceImpl(),
    );
    Get.lazyPut<ListingRepository>(() => ListingRepositoryImpl(Get.find()));
    Get.lazyPut<ProvincesRepository>(() => ProvincesRepositoryImpl(Get.find()));

    Get.lazyPut(() => FilterUseCase(Get.find()));
    Get.lazyPut(() => GetDistrictUseCase(Get.find()));
    Get.lazyPut(() => GetWardUseCase(Get.find()));

    Get.put(
      FilterController(Get.find(), Get.find(), Get.find()),
      permanent: true,
    );
  }
}
