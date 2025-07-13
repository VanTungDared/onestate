import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../core/utils/api/api_client.dart';
import '../../../core/utils/constants/api_url.dart';
import '../../models/provinces_model.dart';

abstract class ProvincesRemoteDataSource {
  Future<Either<String, List<ProvincesModel>>> getDistricts(String province);

  Future<Either<String, List<ProvincesModel>>> getWards(
      String province,
      String district,
  );
}

class ProvincesRemoteDataSourceImpl implements ProvincesRemoteDataSource {
  @override
  Future<Either<String, List<ProvincesModel>>> getDistricts(
      String province,
  ) async {
    try {
      final url = ApiUrl.getDistricts(codeDistrict: province);

      final response = await Get.find<DioClient>().get(url);
      final jsonData = response.data['data'];
      final result =
          (jsonData as List)
              .map((e) => ProvincesModel.fromJson(e as Map<String, dynamic>))
              .toList();
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        final errorMessage =
            e.response?.data['message'] ?? 'Get districts failure';
        return Left(errorMessage);
      }
      //return const Left('An unexpected error occurred');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProvincesModel>>> getWards(
      String province,
      String district,
  ) async {
    try {
      final url = ApiUrl.getWards(
        codeDistrict: province,
        codeWard: district,
      );

      final response = await Get.find<DioClient>().get(url);
      final jsonData = response.data['data'];
      final result =
          (jsonData as List)
              .map((e) => ProvincesModel.fromJson(e as Map<String, dynamic>))
              .toList();
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data['message'] ?? 'Get wards failure';
        return Left(errorMessage);
      }
      //return const Left('An unexpected error occurred');
      return Left(e.toString());
    }
  }
}
