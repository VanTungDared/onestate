import 'package:get/get.dart';

import '../../../../data/datasources/remote/provinces_remote_data_source.dart';
import '../../../../data/repositories/provinces_repository_impl.dart';
import '../../../../domain/repositories/provinces_repository.dart';
import '../../../../domain/usecases/get_district_use_case.dart';
import '../../../../domain/usecases/get_ward_use_case.dart';
import 'filter_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProvincesRemoteDataSource>(
      () => ProvincesRemoteDataSourceImpl(),
    );
    Get.lazyPut<ProvincesRepository>(() => ProvincesRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetDistrictUseCase(Get.find()));
    Get.lazyPut(() => GetWardUseCase(Get.find()));
    Get.lazyPut(() => FilterController(Get.find(), Get.find()));
  }
}
