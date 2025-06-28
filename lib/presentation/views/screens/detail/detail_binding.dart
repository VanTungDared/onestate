import 'package:app_real_estate/domain/usecases/get_listing_by_id_use_case.dart';
import 'package:get/get.dart';

import '../../../../data/datasources/remote/listing_remote_data_source.dart';
import '../../../../data/repositories/listing_repository_impl.dart';
import '../../../../domain/repositories/listing_repository.dart';
import 'detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListingRemoteDataSource>(() => ListingRemoteDataSourceImpl());
    Get.lazyPut<ListingRepository>(() => ListingRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetListingByIdUseCase(Get.find()));
    Get.lazyPut(() => DetailController(Get.find()));
  }
}
