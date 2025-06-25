import 'package:get/get.dart';

import '../../../../core/utils/api/api_client.dart';
import '../../../../data/datasources/remote/auth_remote_data_source.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../domain/usecases/login_usecase.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClient());
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => LoginController(Get.find()));
  }
}
