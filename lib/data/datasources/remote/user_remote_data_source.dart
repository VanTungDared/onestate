import 'package:app_real_estate/data/models/logout_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../core/utils/api/api_client.dart';
import '../../../core/utils/constants/api_url.dart';
import '../../models/UserModel.dart';

abstract class UserRemoteDataSource {
  Future<Either> getUser();
  Future<Either> logout();
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

  @override
  Future<Either> logout() async {
    try {
      var response = await Get.find<DioClient>().post(ApiUrl.logout);
      // dữ liệu logout trả về: message, statusCode, timestamp
      final data = response.data;
      final result = LogoutResponse.fromJson(data);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data['message'] ?? 'Logout failure';
        return Left(errorMessage);
      }
      return const Left('An unexpected error occurred');
    }
  }
}
