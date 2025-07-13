import 'package:app_real_estate/domain/repositories/provinces_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/remote/provinces_remote_data_source.dart';
import '../models/provinces_model.dart';

class ProvincesRepositoryImpl implements ProvincesRepository {
  final ProvincesRemoteDataSource remoteDataSource;

  ProvincesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, List<ProvincesModel>>> getDistricts(String province) async {
    final result = await remoteDataSource.getDistricts(province);

    return result.fold((error) => Left(error), (districts) => Right(districts));
  }

  @override
  Future<Either<String, List<ProvincesModel>>> getWards(String province, String district) async {
    final result = await remoteDataSource.getWards(province, district);
    return result.fold((error) => Left(error), (wards) => Right(wards));
  }
}
