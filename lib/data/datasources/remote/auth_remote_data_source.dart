import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../core/utils/api/api_client.dart';
import '../../../core/utils/constants/api_url.dart';

abstract class AuthRemoteDataSource {
  Future<Either> login(String phoneNumber, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either> login(String phoneNumber, String password) async {
    try {
      var response = await Get.find<DioClient>().post(
        ApiUrl.signup,
        data: {"phoneNumber": phoneNumber, "password": password},
      );
      return Right(response);
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data['message'] ?? 'Signup failed';
        return Left(errorMessage);
      }
      return const Left('An unexpected error occurred');
    }
  }
}
