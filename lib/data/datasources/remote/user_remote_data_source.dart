import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../core/utils/api/api_client.dart';
import '../../../core/utils/constants/api_url.dart';
import '../../models/UserModel.dart';

abstract class UserRemoteDataSource {
  Future<Either> getUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<Either> getUser() async {
    try {
      var response = await Get.find<DioClient>().get(ApiUrl.getUser);
      final data = response.data['data'];
      final user = UserModel.fromJson(data);
      return Right(user);
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data['message'] ?? 'Get user failure';
        return Left(errorMessage);
      }
      return const Left('An unexpected error occurred');
    }
  }
}
