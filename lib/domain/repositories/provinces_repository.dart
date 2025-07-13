
import 'package:app_real_estate/data/models/provinces_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProvincesRepository {
  Future<Either<String, List<ProvincesModel>>> getDistricts(String province);
  Future<Either<String, List<ProvincesModel>>> getWards(String province, String district);
}
